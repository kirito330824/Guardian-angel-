import socket
import time
from multiprocessing import Process, Queue, Array, Lock
from colour import Color
import math
from scipy.interpolate import griddata
import pygame
import numpy as np

import os



# some utility functions
def constrain(val, min_val, max_val):
    return min(max_val, max(min_val, val))


def map_value(x, in_min, in_max, out_min, out_max):
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min

def socket_receive(q):
    server = socket.socket()
    server.bind(('0.0.0.0', 25565))
    server.listen()
    sock, addr = server.accept()
    

    while True:
        tmp_data = sock.recv(1024)
        if tmp_data:
            ## TODO: Decode all array data

            q.put(tmp_data.decode("utf8"), block=True)


def ai_algorithm(q):

    # low range of the sensor (this will be blue on the screen)
    MINTEMP = 0.0

    # high range of the sensor (this will be red on the screen)
    MAXTEMP = 32.0

    # how many color values we can have
    COLORDEPTH = 1024

    # pylint: disable=no-member
    pygame.init()
    # pylint: enable=no-member

    # pylint: disable=invalid-slice-index
    points = [(math.floor(ix / 8), (ix % 8)) for ix in range(0, 64)]
    grid_x, grid_y = np.mgrid[0:7:32j, 0:7:32j]
    # pylint: enable=invalid-slice-index

    # sensor is an 8x8 grid so lets do a square
    height = 240
    width = 240

    # the list of colors we can choose from
    blue = Color("indigo")
    colors = list(blue.range_to(Color("red"), COLORDEPTH))

    # create the array of colors
    colors = [(int(c.red * 255), int(c.green * 255), int(c.blue * 255)) for c in colors]

    displayPixelWidth = width / 30
    displayPixelHeight = height / 30

    lcd = pygame.display.set_mode((width, height))

    lcd.fill((255, 0, 0))

    pygame.display.update()
    pygame.mouse.set_visible(False)

    lcd.fill((0, 0, 0))
    pygame.display.update()

    pygame.event.get()
    count = 0
    with open("rawdata.csv", "w", encoding = "utf-8") as fd:

        while True:
            data = []
            data = q.get(block=True).split(",")

            dataLength = len(data)
            print("DATA LENGTH "+ str(dataLength))
            if dataLength != 64:
                continue
            
            try:
                message = ""
            
                print("---------------------")
                for i in range (8):
                    for j in range (8):
                        message += str(data[i*8+j]) + ","
                print("---------------------")
        
    
                fd.write(str(time.time()) + "," + message + "\n")

                print(data)
                count+=1
                print("COUNT: " + str(count))

            
                pixels = [map_value(float(p), MINTEMP, MAXTEMP, 0, COLORDEPTH - 1) for p in data]

                # perform interpolation
                bicubic = griddata(points, pixels, (grid_x, grid_y), method="cubic")
            
                # draw everything
                for ix, row in enumerate(bicubic):
                    for jx, pixel in enumerate(row):
                        pygame.draw.rect(
                        lcd,
                        colors[constrain(int(pixel), 0, COLORDEPTH - 1)],
                    (
                        displayPixelHeight * ix,
                        displayPixelWidth * jx,
                        displayPixelHeight,
                        displayPixelWidth,
                    ),
                )
                pygame.display.update()

                
            except:
                continue

            time.sleep(0.1)


if __name__ == '__main__':
    q = Queue()

    a = Process(target=socket_receive, args=(q,))
    b = Process(target=ai_algorithm, args=(q,))
    
    a.start()
    b.start()

    a.join()
    b.join()
