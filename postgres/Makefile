all: build run

build:
	docker build --no-cache -t postgres-9.5 .

run:
	docker run --rm --name postgres-9.5 -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $(HOME)/docker/volumes/postgres:/var/lib/postgresql/data postgres-9.5
