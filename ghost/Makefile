#TOKEN = Ymh2WhGLpVKzEBoPxxoCVIyEzC2z44zNLODxK6pSxq02zbrxzCf8eR4mhjr4Unv0fx4AYUxCXxU9RuvTKiD313cEK0nW6B2ZLlDNfeBx5TtTTgrTMWnDoaKrHxAtzAndIEKxFwDnfWITZNFcfAgEVMiCpthHmzNRPpZn8QGUO0CHmcBdsQbjrCBmGSmJsKoxDPVgVC6hMHuqPH771i99X79I34Y4ARY19Hawt4N4cNvQzWqlL97iR0OOekqIgrR
#TS = $(shell date '+%Y_%m_%d_%H_%M')

content.zip:
	cd content && zip -r ../content.zip .

content:
	unzip content.zip -d content

backup:
	#curl http://testgbif.nrm.se/ghost/api/v0.1/db/?access_token=$(TOKEN) > backup_$(TS).json
	docker exec ghost-backup backup

restore:
	docker exec -it ghost-backup restore -i

clean:
	rm content.zip