postgres:
	docker run --name postgreslatest -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:latest

createdb:
	docker exec -it postgreslatest createdb --username=root --owner=root example_bank

dropdb:
	docker exec -it postgreslatest dropdb example_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/example_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/example_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test