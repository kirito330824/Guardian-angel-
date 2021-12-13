import numpy as np

dataReceived = np.linspace(20, 40, 64)
print(dataReceived)


FMax = np.max(dataReceived)
FMin = np.min(dataReceived)
FGlobalMin = -1

F = np.array(dataReceived)
F = F.reshape(8, 8)
print(F)


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


ItiList = []
#print(calculateIti(F, FMin, FMax, FGlobalMin, 1))
for i in range(1, 5):
    print(calculateIti(F, FMin, FMax, FGlobalMin, i))
    ItiList.append(calculateIti(F, FMin, FMax, FGlobalMin, i))

# print(ItiList)
print(calculatePti(ItiList))


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


timeSet = []
possibleThreshold = []
for i in range(0.5, 2, 0.01):
    if(findThersold(timeSet, i)):
        possibleThreshold.append(i)


def detectExit(timeSet, thersold):
    path = []
    for i in range(len(timeSet)):
        F = timeSet[i]
        ItiList = []
        for j in range(1, 5):
            ItiList.append(calculateIti(F, FMin, FMax, FGlobalMin, i))
        Pti = calculatePti(ItiList)
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
