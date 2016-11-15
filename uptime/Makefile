TS= $(shell date "+%Y-%m-%d-%H-%M")
DB=mongo

test:
	echo $(TS)

all: up

backup-uptime:
	@echo "Backing up data"
	@docker exec -it $(DB) \
		sh -c "mongodump --out=/tmp/dump_$(TS)"
	@mkdir -p backups && \
		docker cp $(DB):/tmp/dump_$(TS) backups/dump && \
		docker cp $(DB):/tmp/dump_$(TS) backups/dump_$(TS)

restore-uptime:
	@echo "Restoring from a backup"
	@docker cp backups/dump $(DB):/tmp/dump
	@docker exec -it $(DB) \
		sh -c "mongorestore --drop --dir=/tmp/dump"
#		sh -c "mongo uptime --eval 'db.dropDatabase()' && mongorestore"
