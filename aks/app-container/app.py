#!flask/bin/python
from flask import Flask
app = Flask(__name__)
from flask import Flask
from flask import request
app = Flask(__name__)
@app.route('/healthcheck', methods=['GET'])
def healthcheck():
    print("/healthcheck triggered")
    return 'success'

@app.route('/', methods=['GET'])
def appcheck():
    print("application is running")
    return 'Test Application is running'

@app.route('/webservice1', methods=['GET'])
def webservice1():
    print("/webservice1")
    return 'webservice1 is running'

@app.route('/webservice2', methods=['GET'])
def webservice2():
    print("/webservice2")
    return 'webservice2 is running'

@app.route('/webservice3', methods=['GET'])
def webservice3():
    print("/webservice3")
    return 'webservice3 is running'


@app.route('/testpost', methods=['POST'])
def testpost():
    print("/testpost triggered")
    print(request.is_json)
    content = request.get_json()
    print(content)
    #print(content['id'])
    #print(content['name'])
    return 'JSON posted'

app.run(host='0.0.0.0', port=80)