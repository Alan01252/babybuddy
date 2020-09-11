#!/bin/bash
source /vault/secrets/babybuddy 
python manage.py migrate --noinput && python manage.py createcachetable && gunicorn babybuddy.wsgi -b :8000 --log-level=info
