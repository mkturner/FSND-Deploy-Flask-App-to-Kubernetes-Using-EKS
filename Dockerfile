# Specify base image, recent version of Python
FROM python:3.7-slim-stretch

# Create a working directory
RUN mkdir /app

# Change into WORKDIR, copy requirements & project files
WORKDIR /app
ADD . .

# Install Python Dependencies
RUN pip install -r requirements.txt

# Expose port where gunicorn will listen
EXPOSE 8080

# Run Flask on gunicorn
# main:APP means app module : app file
# -b means bind ports
# --workers means how many processes to run to serve requests
CMD ["gunicorn", "main:APP", "-b", "0.0.0.0:8080", "--workers", "4"]
