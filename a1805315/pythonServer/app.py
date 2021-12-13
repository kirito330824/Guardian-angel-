from numpy.lib.function_base import rot90
import csv
import numpy as np
from flask import flask
import json
import requests
import mysql.connector
from flask_socketio import SocketIO, send
from flask import g
import pandas as pd
import firebase_admin   ## pip3 install firebase-admin
from firebase_admin import messaging, credentials
import os

path=[]
timerLeave = 0;
timerFall = 0;

def send_notification(registration_token,msg_title,msg_body):
    # [START send_to_token]
    # This registration token comes from the client FCM SDKs.

    message = messaging.Message(
        notification=messaging.Notification(
            title= msg_title,
            body=msg_body,
        ),
        token=registration_token
    )
    messaging.send(message)
    #print("END RESPONSE",response)

file_path = os.getcwd()
cred = credentials.Certificate(file_path+"/guardian-angel-a-firebase-adminsdk-nvsyj-25c86b0dea.json")
default_app = firebase_admin.initialize_app(cred)
temp_token = "cjH0j5GQ_W0:APA91bHrdQizANHyPZsB9E0EzNDuFwhedU61HPEjkt7o7a7tVG4YtUK8RRHRfoTDS7fBocYz81lft7KmFvYjZY-88DArp3vjIhDoqqELfPSyctxT4UbD4a-0_N43mZHmBuGdg4W6tlza"
# print("BEFORE")
# send_notification(temp_token,"Alert","Patient Fall!")
# print("END")



class Patient(object):
    def __init__(self, patientname, patientHeight, patientWeight, patientAge, patientGender, monitorSys):
        self.patientName = patientname
        self.patientHeight = patientHeight
        self.patientWeight = patientWeight
        self.patientAge = patientAge
        self.patientGender = patientGender
        self.monitorSys = monitorSys


def calculateIt(F, FMin, FMax, FGlobalMin, x, y):
    return (F[x][y]-FMin)/(FMax-FGlobalMin)


def calculateIti(F, FMin, FMax, FGlobalMin, i):
    Iti = []
    xmin = (i-1)*2
    xmax = (i-1)*2+2
    ymin = 0
    ymax = 8

    for m in range(xmin, xmax):
        for n in range(ymin, ymax):
            Iti.append(calculateIt(F, FMin, FMax, FGlobalMin, m, n))
    return Iti


def calculatePti(ItiList):
    Pti = []
    for i in range(4):
        sum = 0
        for j in range(len(ItiList[i])):
            sum += (ItiList[i][j])*(ItiList[i][j])
        Pti.append(sum)
    return Pti

# print(calculatePti(ItiList))
# resultlist.append(ItiList)
# print(resultlist)


def findThersold(timeSet, thersold):
    for i in range(len(timeSet)):
        F = timeSet[i]
        ItiList = []
        for j in range(1, 5):
            ItiList.append(calculateIti(F, FMin, FMax, FGlobalMin, i))
        Pti = calculatePti(ItiList)
        count = 0
        for k in range(len(Pti)):
            if(Pti[k]) > thersold:
                count += 1
            if count >= 2:
                return False
    return True


def detectExit(timeSet, thersold):
    path = []
    for i in range(len(timeSet)):
        F = timeSet[i]
        ItiList = []
        for j in range(1, 5):
            ItiList.append(calculateIti(F, FMin, FMax, FGlobalMin, i))
        Pti = calculatePti(ItiList)
        print(Pti)
        for k in range(len(Pti)):
            if(Pti[k]) > thersold:
                path.append(k)
    return path


def detectDirection(path):
    if path[0] > path[3]:
        return "Enter"
    elif path[0] < path[3]:
        return "Exit"
    else:
        return "No action detected"


app = Flask(__name__)
socketio = SocketIO(app)


@socketio.on('exitSensor')
def exitDetect(data):
    global timerLeave
    global path
    if timerLeave == 0:
        ##print('received message: ' + data)
        new_data = np.array(data.split(','))
        new_data = new_data.astype(float)
        new_data = new_data.reshape((8, 8))
        # ##new_data = np.array(data.split(',')).astype(float).reshape((8, 8))
        new_data = np.rot90(new_data)
        print("------")
        print(new_data)
        print("------")
        F=new_data
        FMax = np.max(F)
        FMin = np.min(F)
        FGlobalMin = -1
        ItiList = []
        currentPti = []
        previousIndex = -1
        thersold = 0.14
        for i in range(1, 5):
            ItiList.append(calculateIti(F, FMin, FMax, FGlobalMin, i))
        currentPti = calculatePti(ItiList)
        # print("CURRENR PTI",end=" ")
        # print(currentPti)
        currentIndex = -1
        hightestP = 0
        for i in range(len(currentPti)):
            if currentPti[i] > thersold:
                if currentPti[i] > hightestP:
                    hightestP = currentPti[i]
                    currentIndex = i
    # if currentIndex = 0, initial the path
        if(len(path) !=0):
            previousIndex = path[-1]
        if currentIndex == 0:
            path = [0]
        elif currentIndex == -1:
            path = []
        elif currentIndex > previousIndex:
            path.append(currentIndex)
            previousIndex = currentIndex
        if path == [0,1,2,3] or path ==[0,3] or path ==[1,2,3] or path ==[2,3] or path == [1,3]:
            timer=50
            send_notification(temp_token,"Alert","Patient leave the room!")
            print("Exit")
        # print("PATH:",end=" ")
        # print(path)
    else:
        timerLeave -=1

    
    # Send notification

@socketio.on("fallSensor")
def fallDetect(data):
    global timerFall
    global classifier
    new_data = np.array(data.split(','))
    new_data = new_data.astype(float)
    print("---------")
    print(new_data)
    print("---------")

    if timerFall == 0:
        predictResult = classifier.predict([new_data])
        print("PredictResult",end = " ")
        print(predictResult)
        if predictResult ==1:
            timerFall = 50
            send_notification(temp_token,"Alert","Patient Fall!")
            print("Fall Sensor received")
    else:
        timerFall-=1

        



@app.route('/hello', methods=['GET'])
def gethello():
    data = "<h1>Hello</h1>"
    global path
    path.append("hello1")

    return (path[0])


@app.route('/getdata', methods=['GET', 'POST'])
def getData():
    mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        password='password',
        database='guardianAngel',
        port=3306
    )
    patients = []
    patientData = []
    patientMonitorSys = []
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM patient")
    results = mycursor.fetchall()
    for row in results:
        patientData.append(row)
    count = 0
    for patient in patientData:
        patientid = patient[0]
        mycursor.execute(
            "SELECT actionName,status FROM MonitorSys WHERE (patient_idpatient = %i)" % patientid)
        results = mycursor.fetchall()
        patientMonitorSys.append([])
        for data in results:
            patientMonitorSys[count].append(
                {"actionName": data[0], "status": data[1]})
        count += 1

    for i in range(count):
        patient = Patient(patientData[i][1], patientData[i][2], patientData[i]
                          [3], patientData[i][4], patientData[i][5], patientMonitorSys[i])
        patients.append(patient.__dict__)
    dataToBeGet = {"patients": patients}
    return dataToBeGet





dataset = pd.read_csv('falldata.csv')
X = dataset.iloc[:, 0:64].values
y = dataset.iloc[:, 64].values

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.25, random_state = 0)

from sklearn.preprocessing import StandardScaler
sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)

from sklearn.svm import SVC
classifier = SVC(kernel='linear',random_state=0)
classifier.fit(X_train,y_train)



# y_pred = classifier.predict(testUseData)
# print ("y_pred",end='')
# print(y_pred)

print('END OF MODEL')

    # FMax = np.max(F)
    # FMin = np.min(F)
    # FGlobalMin = -1
    # ItiList = []
    # currentPti = []
    # previousIndex = -1
    # thersold = 1.8
    # for i in range(1, 5):
    #     ItiList.append(calculateIti(F, FMin, FMax, FGlobalMin, i))
    # currentPti = calculatePti(ItiList)
    # currentIndex = -1
    # hightestP = 0
    # path = []
    # for i in range(len(currentPti)):
    #     if currentPti[i] > thersold:
    #         if currentPti > hightestP:
    #             hightestP = currentPti
    #             currentIndex = i
    # # if currentIndex = 0, initial the path
    # if currentIndex == 0:
    #     path = [0]
    # elif currentIndex == -1:
    #     path = []
    # elif currentIndex > previousIndex:
    #     path.append(currentIndex)
    #     previousIndex = currentIndex

socketio.run(app, host='0.0.0.0', port=5000)
