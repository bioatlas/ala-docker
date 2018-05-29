#! make

include ../env/.envwordpress

NOW := $(shell date +%Y%m%d-%H%M%S)
UID = $(shell id -u)
GID = $(shell id -g)
PWD = $(shell pwd)

test:
		echo "$(MYSQL_USER)"

backup:
	docker run --rm --volumes-from wordpress \
		-u $(UID):$(GID) -v $(PWD):/tmp alpine \
		sh -c "tar czf /tmp/wordpress-files-$(NOW).tgz -C /var/www/html ./"

	docker exec mysqldbwordpress bash -c \
		"mysqldump -u $(MYSQL_USER) -p'$(MYSQL_PASSWORD)' -h 127.0.0.1 $(MYSQL_DATABASE)" | gzip > wordpress-db-$(NOW).sql.gz

	cp wordpress-files-$(NOW).tgz wordpress-files-latest.tgz
	cp wordpress-db-$(NOW).sql.gz wordpress-db-latest.sql.gz

restore:
	docker run --rm --volumes-from wordpress \
		-v $(PWD):/tmp alpine \
		sh -c "cd /var/www/html && tar xvf /tmp/wordpress-files-latest.tgz"

	gunzip -c wordpress-db-latest.sql.gz | docker exec -i mysqldbwordpress mysql -u $(MYSQL_USER) -p'$(MYSQL_PASSWORD)' -h 127.0.0.1 $(MYSQL_DATABASE)
