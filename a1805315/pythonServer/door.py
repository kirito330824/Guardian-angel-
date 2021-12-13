import numpy as np
import csv
from numpy.lib.function_base import rot90


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


if __name__ == "__main__":
    datalist = []
    # execute only if run as a script
    with open("test.csv", newline='\n') as csvfile:
        spamreader = csv.reader(csvfile, delimiter='\t', quotechar='|')
        for row in spamreader:

            test_matrix = np.array(row).astype(float).reshape((8, 8))
            test_matrix = np.rot90(test_matrix)
            datalist.append(test_matrix)
    path = []
    timePti = []
    for i in range(4):
        F = datalist[i]
        FMax = np.max(F)
        FMin = np.min(F)
        FGlobalMin = -1
        ItiList = []
        for i in range(1, 5):
            ItiList.append(calculateIti(F, FMin, FMax, FGlobalMin, i))
        timePti.append(calculatePti(ItiList))
    print(timePti)
    thersold = 0.19
    for k in range(len(timePti)):
        PtiSlice = (timePti[k])
        print(PtiSlice)
        # print(len(PtiSlice))
        for j in range(4):
            # print(PtiSlice[j])
            if PtiSlice[j] > thersold:
                print(PtiSlice[j])
                path.append(j)
    print(path)
    if(path[3] == 0 and path[0] == 3):
        print("Exit")
    elif(path[3] == 3 and path[0] == 0):
        print("Enter")
