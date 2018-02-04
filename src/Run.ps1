docker rm -f $(docker ps -aq)
Docker run -d -p 15672:15672 --memory 2048m --cpus 4 --name rabbitmq kerwinc/rabbitmq-windows
docker exec rabbitmq ipconfig