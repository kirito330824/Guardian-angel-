import socket
import time

import os
import sys

import numpy as np
import busio
import board

from datetime import datetime

from scipy.interpolate import griddata
import adafruit_amg88xx

from multiprocessing import Process, Queue, Array, Lock

i2c_bus = busio.I2C(board.SCL, board.SDA)

os.putenv("SDL_FBDEV", "/dev/fb1")

# initialize the sensor
sensor = adafruit_amg88xx.AMG88XX(i2c_bus)

grid_x, grid_y = np.mgrid[0:7:32j, 0:7:32j]

# let the sensor initialize
time.sleep(0.1)

with open("rawdata.csv", "w", encoding = "utf-8") as fd:
    while True:
        # read the pixels
        pixels = []
        for row in sensor.pixels:
            pixels = pixels + row
        
        message = ""
            
        print("---------------------")
        for i in range (8):
            print(pixels[i*8+0:i*8+7])
            for j in range (8):
                message += str(pixels[i*8+j]) + ","
        print("---------------------")
        
        

        fd.write(str(time.time()) + "," + message + "\n")
        

