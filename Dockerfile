FROM postgres:9.6.18-alpine

ARG db_user
ARG db_password
ARG db_name

ENV DB_USER=$db_user
ENV DB_PASSWORD=$db_password
ENV DB_NAME=$db_name

# (OPTIONAL) Use this command when the iamge is NOT `alpine`
#RUN apt-get update -y && apt-get install -y vim
# (OPTIONAL) This command is for `alpine` image to install package
#RUN apk add --update vim

COPY ./init.sh /docker-entrypoint-initdb.d/

EXPOSE 5432
