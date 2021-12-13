import socket
import time

server = socket.socket()
server.bind(('0.0.0.0', 25565))
server.listen()
sock, addr = server.accept()
data = ""
while True:
    print("YO")
    tmp_data = sock.recv(1024)
    print("22222")
    if tmp_data:
        print(tmp_data.decode("utf8"))
        time.sleep(1)
    else:
        break
##print('%s发送的内容：%s'%(addr[0],data))

sock.close()
