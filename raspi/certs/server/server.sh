echo "append -server to each answer"

openssl genrsa -des3 -out server.key 2048

openssl genrsa -out server.key 2048

echo "When prompted for the CN (Common Name), please enter either your server (or broker) hostname or domain name."
openssl req -out server.csr -key server.key -new

openssl x509 -req -in server.csr -CA ../ca/ca.crt -CAkey ../ca/ca.key -CAcreateserial -out server.crt -days 1825
