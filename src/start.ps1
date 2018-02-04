Set-Location "C:\Program Files\RabbitMQ Server\rabbitmq_server-3.7.3\sbin"

Write-Host "Starting RabbitMQ Server:"
& .\\rabbitmq-server.bat

Write-Host "Getting RabbitMQ Server Status:"
& .\rabbitmqctl.bat status