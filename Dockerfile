FROM arm32v7/python:3.7
ENV PYTHONUNBUFFERED 1
RUN apt-get -y install libatlas-base-dev
RUN pip install --upgrade pipenv gunicorn
WORKDIR /app
COPY Pipfile /app/
COPY Pipfile.lock /app/
COPY run.sh /app/
RUN pipenv install --deploy --system --skip-lock -v
ADD manage.py /app/
ADD api /app/api
ADD babybuddy /app/babybuddy
ADD core /app/core
ADD dashboard /app/dashboard
ADD reports /app/reports
ADD static /app/static
ADD etc/gunicorn.py /app/
