# PostgreSQL Container Setup
PostgreSQL setup with Database, User and Roles in a Docker container.


## Build The Image
- To build the image, run the `build.sh` script. Make sure the script has executable permission. 
To allow the script executable permission, run `sudo chmod +x build.sh`
```shell script
./build.sh {dbuser} {dbpassword} {dbname}
```
The above values for **dbname**, **dbname** and **dbname** will be used as the DB Credentials. An example is as follows.
```shell script
./build.sh myuser mypass mydb
```


## Run The PostgreSQL Container
- For teh first time (actually when the volume is not created yet), run the following command. Make sure that 
`{/path/to/a/directory}` exists in host machine.
```shell script
docker run -d --name pg-container \
  -v {/path/to/a/directory}:/var/lib/postgresql/data \
  -e POSTGRES_USER='{superusername}' -e POSTGRES_DB='{db_name}' -e POSTGRES_PASSWORD='{superuser-password}' \
  -p 5435:5432 postgresql-custom-image:latest \
  -c listen_addresses='*'
```
Note: replace all the {xyz} with the actual value. An example is as follows.
```shell script
docker run -d --name pg-container \
  -v /tmp/docker/data:/var/lib/postgresql/data \
  -e POSTGRES_USER='postgres' -e POSTGRES_DB='pgdb' -e POSTGRES_PASSWORD='pgpass' \
  -p 5435:5432 postgresql-custom-image:latest \
  -c listen_addresses='*'
```
- If you have the volume created already, start the container using the following command.
```shell script
docker run -d --name pg-container -v {/path/to/a/directory}:/var/lib/postgresql/data  \
-p {host_port}:{container_port} postgresql-custom-image:latest -c listen_addresses='*'
```
Note: If you send the postgres conf file at the time of sending docker build context, the you can ignore 
`listen_addresses='*'` from the above two commands.


## Connect To The Databse Server Using The PostgreSQL Client
- To connect to the DB server, run
```shell script
psql -h {host} -p {port} -U {username} {db_name}
```
Example: If you run the container in your local machine, then run `psql -h localhost -p 5435 -U myuser mydb`. 
It'll prompt for password input. Here, the host port is **5435**, db username is **myuser** and db name is **mydb**. 
Make sure that PostgreSQL client is installed in your machine where you are trying to connect to the postgresql 
server from.