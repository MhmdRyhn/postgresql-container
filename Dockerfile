FROM postgres:10.13

ARG db_user
ARG db_password
ARG db_name

ENV DB_USER=$db_user
ENV DB_PASSWORD=$db_password
ENV DB_NAME=$db_name

# (OPTIONAL) Use this command if you need to install vim
#RUN apt-get update -y \
#  && apt-get install -y vim \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/*

COPY ./init.sh /docker-entrypoint-initdb.d/

EXPOSE 5432
