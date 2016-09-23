TOKEN = XQvTXVjZMoUmQOn5yjMJUHQDkRRYt0Hj2XRKV9Htsei3fOChflC37YQV58wdaT1krRDNfI636O2E0CSCXeYdSAlvT9Ezw8BGAITAzBQRSOXZaxI45os44DrI1AuMl9fnT8UDoynujoZbTnXC5j74JRlQSjGMGXUtk2lbwc0CaC2tpJAci70IoODo7yKHdifEL8H7zgeq9Zp64VS3zhrSYo6f0pO0zSRGT5knrkbRRkmbfoFpWAaVQzWNbMKhoBf
TS = $(shell date '+%Y_%m_%d_%H_%M')

content.zip:
	cd content && zip -r ../content.zip .

backup:
	curl http://localhost:2368/ghost/api/v0.1/db/?access_token=$(TOKEN) > backup_$(TS).json

clean:
	rm content.zip
