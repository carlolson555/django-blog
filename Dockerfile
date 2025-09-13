 FROM python:3.13-slim

 # Set working directory in the container
 WORKDIR /app

 # Copy requirements.txt to install dependencies
 COPY requirements.txt .

 # Install dependencies
 RUN pip install --no-cache-dir -r requirements.txt

 # Copy the entire project
 COPY . .

 # Collect static files
 RUN python manage.py collectstatic --noinput

 # Expose port 8000 (internal port for Gunicorn)
 EXPOSE 8000

 # Run migrations and start Gunicorn
 CMD ["sh", "-c", "python manage.py migrate && gunicorn myblog.wsgi --bind 0.0.0.0:8000"]
