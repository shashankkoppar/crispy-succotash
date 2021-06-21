#!/bin/bash

until nc -zv db 5432
do
  echo "Waiting for postgres to be up!"
  sleep 10
done

# change directory to source code
cd /code/

if [ -n "${APP_TYPE+set}" ]; then
  case $APP_TYPE in

    app)
      echo -n "Running migrations and starting app"
      python manage.py migrate && python manage.py runserver 0.0.0.0:8000
      ;;

    worker)
      echo -n "Running worker"
      while true
      do
        python manage.py update_feeds
        sleep 10
      done
      ;;

    *)
      echo -n "unknown, pass only app or worker"
      exit 1
      ;;
  esac
else
  echo "Pass APP_TYPE"
  exit 1
fi
