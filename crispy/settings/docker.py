from .base import *


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'crispy',
        'USER': 'postgres',
        'PASSWORD': 'password',
        'HOST': '{{DB_HOST}}',
        'PORT': 5432,
    }
}
