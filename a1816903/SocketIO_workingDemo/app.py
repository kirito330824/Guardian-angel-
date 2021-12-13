from flask import Flask
import json
import requests
# import mysql.connector
import eventlet
from flask_socketio import SocketIO,send
import numpy as np

print("Loading Flask Server..")
print("20%")

class Patient(object):
    def __init__(self,patientname,patientHeight,patientWeight,patientAge,patientGender,monitorSys):
        self.patientName = patientname
        self.patientHeight = patientHeight
        self.patientWeight =patientWeight
        self.patientAge = patientAge
        self.patientGender = patientGender
        self.monitorSys = monitorSys

print("40%")

app = Flask(__name__)
socketio = SocketIO(app)

print("60%")
@socketio.event
def my_message(data):
    #print('received message: ' + data)
    new_data = np.array(data.split(',')).astype(float).reshape((8,8))
    new_data = np.rot90(new_data)
    print(new_data)

# @app.route('/', methods=['GET', 'POST'])
# def index():
#     return dataToBeGet

print("80%")
if __name__ == '__main__':
    # mydb = mysql.connector.connect(
    #     host= 'localhost',
    #     user= 'root',
    #     password= 'password',
    #     database= 'guardianAngel',
    #     port= 3306
    # )
    # patients = []
    # patientData = []
    # patientMonitorSys=[]
    # mycursor = mydb.cursor()
    # mycursor.execute("SELECT * FROM patient")
    # results = mycursor.fetchall()
    # for row in results:
    #     patientData.append(row)
    # count=0;
    # for patient in patientData:
    #     patientid = patient[0]
    #     mycursor.execute("SELECT actionName,status FROM MonitorSys WHERE (patient_idpatient = %i)"%patientid)
    #     results = mycursor.fetchall()
    #     patientMonitorSys.append([])
    #     for data in results:
    #         patientMonitorSys[count].append({data[0]:data[1]})
    #     count+=1
    # print(patientMonitorSys)

    # for i in range(count):
    #     patient = Patient(patientData[i][1],patientData[i][2],patientData[i][3],patientData[i][4],patientData[i][5],patientMonitorSys[i])
    #     patients.append(patient.__dict__)
    # dataToBeGet = json.dumps(patients)


    #  TODO: 
    # Get Sensor data

    # data structure:
    # numpy array (8,8)
    # numpy rotate 90 degrees

    # Gao want people walk left and right and verify

    print("100%")
    print("Server Ready")
    socketio.run(app,host='0.0.0.0',port= 5000)
    print("6")
