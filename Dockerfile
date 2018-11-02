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

# DOCKER BUILD할때 path에 해당하는 폴더의 전체 내용을
# iMAGES의 /srv/project/ 폴더 내부에 복사
COPY        ./  /srv/projects
WORKDIR     /srv/projects
RUN         pip3 install -r requirements.txt

# 프로세스를 실행할 명령
WORKDIR     /srv/projects/app
CMD         python3 manage.py runserver 0:8000