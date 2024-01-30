# Use the official Python image
FROM python:3.9

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /src

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt

# Copy the source code into the container
COPY src .

# Set the entry point
CMD ["python", "manage.py"]
