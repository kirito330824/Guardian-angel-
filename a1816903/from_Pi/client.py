import socket
import time

import os
import math

import numpy as np
import busio
import board

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
    
client = socket.socket()
client.connect(('192.168.1.253', 25565))

while True:
    # read the pixels
    pixels = []
    for row in sensor.pixels:
        pixels = pixels + row
    
    message = ""
        
    print("---------------------")
    for i in range (8):
        print(pixels[i*8+0:i*8+8])
        for j in range (8):
            message += str(pixels[i*8+j]) + ","
    print("---------------------")
    
    message = message[:-1]
    
    client.send(message.encode("utf8"))
    
    time.sleep(0.1)

client.close()
