import socketio
import time

import os

import busio
import board

from scipy.interpolate import griddata
import adafruit_amg88xx

i2c_bus = busio.I2C(board.SCL, board.SDA)
os.putenv("SDL_FBDEV", "/dev/fb1")

# initialize the sensor
sensor = adafruit_amg88xx.AMG88XX(i2c_bus)
# let the sensor initialize
time.sleep(0.1)

sio = socketio.Client()

def send_data():
    while True:
        # read the pixels
        pixels = []
        for row in sensor.pixels:
            pixels = pixels + row
        message = ""
        for i in range (8):
            for j in range (8):
                message += str(pixels[i*8+j]) + ","
        message = message[:-1]
        sio.emit("my_message",message)
        sio.sleep(0.2)

@sio.event
def connect():
    print('connection established')
    sio.start_background_task(send_data)

@sio.event
def disconnect():
    print('disconnected from server')

sio.connect('http://192.168.1.68:5000')