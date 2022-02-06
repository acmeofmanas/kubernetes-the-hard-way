openssl genrsa -out ca.key 2048

sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf

	openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr


openssl x509 -req -in ca.csr -signkey ca.key -CAcreateserial  -out ca.crt -days 1000
