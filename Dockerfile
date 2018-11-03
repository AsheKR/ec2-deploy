# ubuntu 설치
FROM        ubuntu:18.04
MAINTAINER  teachmesomething2580@gmail.com

# 기본설정을 위한 패키지 설치 및 업데이트
RUN         apt -y update
RUN         apt -y dist-upgrade
RUN         apt -y install python3-pip

# Nginx, uWSGI 설치
RUN         apt -y install nginx
RUN         pip3 install uwsgi

# requirements.txt파일만 복사 후, 패키지 설치
COPY        requirements.txt /tmp/
RUN         pip3 install -r /tmp/requirements.txt

# DOCKER BUILD할때 path에 해당하는 폴더의 전체 내용을
# iMAGES의 /srv/project/ 폴더 내부에 복사
COPY        ./  /srv/projects
WORKDIR     /srv/projects

ENV         DJANGO_SETTINGS_MODULE  config.settings.production

# 프로세스를 실행할 명령
WORKDIR     /srv/projects/app
# static 파일 합치기, --noinput과 -y는 같다.
RUN         python3 manage.py collectstatic --noinput

# Nginx
# 기존 Nginx 파일 삭제
RUN         rm -rf /etc/nginx/sites-available/*
RUN         rm -rf /etc/nginx/sites-enabled/*
# 프로젝트 Nginx 설정파일 복사 및 enabled 링크 설정
RUN         cp -f /srv/projects/.config/app.nginx /etc/nginx/sites-available/
RUN         ln -sf /etc/nginx/sites-available/app.nginx /etc/nginx/sites-enabled/app.nginx