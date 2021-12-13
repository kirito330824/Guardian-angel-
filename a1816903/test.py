import numpy as np
# import time
# import busio
# import adafruit_amg88xx

# import board

# i2c = busio.I2C(board.SCL, board.SDA)


# while True:
#     amg = adafruit_amg88xx.AMG88XX(i2c)
#     print("--------------------")
#     for pixels in amg.pixels:
#         print(['{0:.1f}'.format(temp) for temp in pixels])
#         print("")
#     time.sleep(1)

test_data = "23.5,24.25,24.0,23.75,23.75,24.25,24.25,24.25,24.25,24.25,24.0,23.75,23.75,24.25,24.0,24.25,24.25,24.75,23.75,23.75,24.0,24.0,24.75,24.5,24.25,24.0,24.0,24.0,24.5,24.5,24.5,24.5,24.0,24.0,23.75,24.0,24.25,24.25,25.0,24.25,24.5,24.5,24.25,24.25,24.25,24.75,24.5,24.5,24.0,24.75,24.0,24.25,24.75,24.0,24.5,24.75,24.25,24.75,24.5,25.0,24.5,24.5,24.5,24.75"

# test_list = test_data.split(',')


# test_list = list(np.array(test_list).astype(float))

# test_list = np.reshape(test_list,(8,8))  works

test_list = np.array(test_data.split(',')).astype(float).reshape((8,8))

print(test_list)