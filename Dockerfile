FROM python:3 as build-amd64
ENV PYTHONUNBUFFERED 1
RUN pip install --upgrade pipenv gunicorn
WORKDIR /app
COPY Pipfile /app/
COPY Pipfile.lock /app/
RUN pipenv install --deploy --system

FROM arm32v7/python:3 as build-arm64
ENV PYTHONUNBUFFERED 1
RUN pip install --upgrade pipenv gunicorn -r requirements.txt

ARG TARGETARCH
FROM build_${TARGETARCH}
ADD manage.py /app/
ADD api /app/api
ADD babybuddy /app/babybuddy
ADD core /app/core
ADD dashboard /app/dashboard
ADD reports /app/reports
ADD static /app/static
ADD etc/gunicorn.py /app/

