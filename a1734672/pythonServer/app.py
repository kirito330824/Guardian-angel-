from flask import Flask
import json
import requests
import mysql.connector
    
mycursor = mydb.cursor()

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    return ("hello world")


# @app.route('/add_status/', methods=['POST'])
# def add_status():
#     if not request.json or 'idMonitorSys' not in request.json or 'actionName' not in request.json:
#         abort(400)
    
#     val = ("1","fallen","active")
#     sql = "INSERT INTO `guardianAngel`.`MonitorSys` (`idMonitorSys`, `actionName`, `status`) VALUES ('%s', '%s', '%s');"
#     meycursor.excute(sql,val)

# @app.route('/update_staus', methods=['POST'])
# def update_status():
#     val = ("fallen","active")
#     sql = "UPDATE status SET  = '%s' WHERE status = '%s'"
#     meycursor.excute(sql,val)
 
    # api.add_resource()
    # api.add_resource()


if __name__ == '__main__':
    mydb = mysql.connector.connect(
        host= 'localhost',
        user= 'root',
        password= 'password',
        database= 'guardianAngel',
        port= 3306
    )

    for row in results:
        print(row)
    app.run(debug=True)

    mycursor.execute("SELECT * FROM patient")
    results = mycursor.fetchall()