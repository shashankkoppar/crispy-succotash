FROM python:3.8-alpine
RUN apk update && apk add curl postgresql-dev gcc python3-dev musl-dev bash netcat-openbsd gettext &&\
    curl -sSL https://git.io/get-mo -o mo &&\
    chmod +x mo &&\
    mv mo /usr/local/bin/

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
