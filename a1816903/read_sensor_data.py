import os
import math
import time

import numpy as np
import pygame
import busio
import board

from scipy.interpolate import griddata

import adafruit_amg88xx

i2c_bus = busio.I2C(board.SCL, board.SDA)

os.putenv("SDL_FBDEV", "/dev/fb1")

# initialize the sensor
sensor = adafruit_amg88xx.AMG88XX(i2c_bus)

grid_x, grid_y = np.mgrid[0:7:32j, 0:7:32j]

# let the sensor initialize
time.sleep(0.1)

while True:

    # read the pixels
    pixels = []
    for row in sensor.pixels:
        pixels = pixels + row 
    
    print("---------------------")
    for i in range (8):
        print(pixels[i*8+0:i*8+7])
    print("---------------------")
