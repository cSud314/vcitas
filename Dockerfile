FROM python:3.10.0a7-alpine3.12 
#Pulls very slim python3 image
WORKDIR /app 
#Creates and uses /app as directory
RUN pip3 install flask
#Installs flask for python3
COPY app.py app.py 
#Copies Main program
CMD ["python3", "app.py"]
#Runs The Program
