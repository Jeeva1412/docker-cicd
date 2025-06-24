# # Use secure and minimal base image
# FROM python:3.12-alpine

# # Set working directory
# WORKDIR /app

# # Environment variables
# ENV PYTHONDONTWRITEBYTECODE=1
# ENV PYTHONUNBUFFERED=1

# # Install build dependencies and security updates
# RUN apk update && apk upgrade && apk add --no-cache \
#     gcc \
#     musl-dev \
#     libffi-dev \
#     python3-dev \
#     py3-pip \
#     build-base \
#     libgcc \
#     libstdc++ \
#     openssl-dev

# # Copy dependency file
# COPY requirements.txt .

# # Install dependencies securely
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy application files
# COPY . .

# # Expose Flask default port
# EXPOSE 5000

# # Start the app
# CMD ["python", "app.py"]

# Use outdated and vulnerable base image (intentionally)
FROM python:3.7-slim

# Set working directory
WORKDIR /app

# Avoid writing .pyc files
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libffi-dev \
    python3-dev \
    build-essential \
    openssl \
 && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY . .

# Expose port
EXPOSE 5000

# Run app
CMD ["python", "app.py"]
