# Use the official Python image as the base image
FROM python:3.10-slim

# Copy your Python script into the container
COPY . /usr/src/app/

# Set the working directory
WORKDIR /usr/src/app/

RUN pip install -r requirements.txt


# Run the Python script
CMD ["python",  "src/main.py"]
