# assign base image
FROM python:3.9-slim

# setting the directory
WORKDIR /app

# install and copy
COPY week5/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# copy application file
COPY week5/ .

# open port
EXPOSE 5000

# run application
CMD ["python", "app.py"]
