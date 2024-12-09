FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1  # Prevent Python from writing .pyc files
ENV PYTHONUNBUFFERED=1        # Ensure output is sent directly to the terminal

WORKDIR /app/backend

COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*
    
# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && apt-get clean

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend

EXPOSE 8000

# Run migrations and start the development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
