# Use the official Python image from the DockerHub
FROM python:3.12-slim
# Set the working directory in the container
WORKDIR /app
# Copy the rest of the application code into the container
COPY FLASK-CONTACT-IDROR/ /app/
# Install the dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt
# Set the entrypoint to wait for MySQL and run the app
ENTRYPOINT ["python", "app.py"]