# Use an official Python runtime as a parent image
FROM python:3.8.2-buster

# Set the working directory in the container
WORKDIR /project

# Install required system dependencies
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless python3-dev build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install librdkafka development package
RUN apt-get update && \
    apt-get install -y librdkafka-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Update pip to the latest version
RUN pip install --upgrade pip

# Copy requirements.txt first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project
COPY . .
