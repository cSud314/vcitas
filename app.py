from flask import Flask, request, jsonify #imports specific sub-modules from main module flask

app = Flask(__name__) #init flask app
app.config["DEBUG"] = True #outputs debug data if something goes wrong\right

@app.route("/", methods=['POST']) #only accepts post request
def home():
        data=request.get_data() #gets raw data
        return data      #return raw data
app.run(host='0.0.0.0', port=80) #runs app
