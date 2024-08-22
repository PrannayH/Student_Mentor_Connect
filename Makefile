.PHONY: server
## Run server and db
server:
	cd server;
	docker run --name mysql-db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:9;
## remove this root user/password in future - insecure method
	sleep 20;
	docker exec -i mysql-db sh -c 'exec mysql -uroot -p"root"' < ./server/setup.sql;
	sleep 20;
	docker run -d --name full-stack-backend -p 8000:8000 full-stack-backend;

build-server:
	cd server && docker build -t full-stack-backend .;

## Run the UI
ui:
	cd client;
	docker run --name full-stack-frontend -p 3000:3000 -d full-stack-frontend;

## Build the UI image
build-ui:
	cd client && docker build -t full-stack-frontend .;
