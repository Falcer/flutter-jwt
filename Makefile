server_build:
	cd server && go build -o ./build/server main.go
server_run:
	cd server && ./build/server
server_dev: server_build server_run