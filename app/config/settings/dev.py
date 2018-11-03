from . base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

WSGI_APPLICATION = 'config.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'HOST': 'wps9th.cttt6v6h6vly.ap-northeast-2.rds.amazonaws.com',
        'NAME': 'ec2_deploy',
        'USER': SECRET_JSON['RDS_DB_ID'],
        'PASSWORD': SECRET_JSON['RDS_DB_PASSWORD'],
        'PORT': 5432,
    }
}