FROM python:3.7.2-slim

COPY . /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install flask

EXPOSE 8080

ENTRYPOINT ["python", "app.py"]

