Set-Location c:\tools

Write-Host "Installing Erlang..."
$erlangInstallProcess = Start-Process -FilePath "c:\tools\otp_win64_20.0.exe" -PassThru -ArgumentList "/S" -NoNewWindow
$erlangInstallProcess
while ($erlangInstallProcess.HasExited -eq $false) {
    Write-Host "Still Installing Erlang. Checking again in a few seconds..."
    Start-Sleep 5
}

Write-Host "Erlang home set to: [$($env:ERLANG_HOME)]"
Write-Host "Erlang service manager path set to: [$($env:ERLANG_SERVICE_MANAGER_PATH)]"

Write-Host "Installing Rabbit..."
Expand-Archive C:\tools\rabbitmq-server-windows-3.7.3.zip -DestinationPath "C:\Program Files\RabbitMQ Server"

Set-Location "C:\Program Files\RabbitMQ Server\rabbitmq_server-3.7.3\sbin\"

Write-Host "Enabling the management portal..."
& .\rabbitmq-plugins.bat enable rabbitmq_management

Write-Host "Install Complete..."