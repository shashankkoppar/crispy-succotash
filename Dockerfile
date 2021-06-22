FROM python:3.8-alpine
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev bash netcat-openbsd wget
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/
EXPOSE 8000
COPY entrypoint.sh /entrypoint.sh
WORKDIR /code/
ENTRYPOINT ["/entrypoint.sh"]
