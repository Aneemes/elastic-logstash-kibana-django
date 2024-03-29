#!/bin/bash

python manage.py collectstatic --no-input

echo "Starting gunicorn server"
gunicorn core.wsgi:application --bind 0.0.0.0:8080 --preload --timeout 90 -w 4