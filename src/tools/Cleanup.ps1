Write-Host "Removing Erlang Downloads:"
Remove-Item -LiteralPath "c:\tools\otp_win64_20.0.exe" -Force

Write-Host "Removing RabbitMQ Downloads:"
Remove-Item -LiteralPath "c:\tools\rabbitmq-server-windows-3.7.3.zip" -Force

Write-Host "Cleanup complete..."