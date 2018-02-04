$erlangUrl = "http://erlang.org/download/otp_win64_20.0.exe"
$erlangTargetFile = "c:\tools\otp_win64_20.0.exe"

$rabbitmqUrl = "https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.3/rabbitmq-server-windows-3.7.3.zip"
$rabbitmqTargetFile = "c:\tools\rabbitmq-server-windows-3.7.3.zip"

function DownloadFile($url, $targetFile)
{ 
    "Downloading $url" 
    $uri = New-Object "System.Uri" "$url" 
    $request = [System.Net.HttpWebRequest]::Create($uri) 
    $request.set_Timeout(15000) #15 second timeout 
    $response = $request.GetResponse() 
    $totalLength = [System.Math]::Floor($response.get_ContentLength()/1024) 
    $responseStream = $response.GetResponseStream() 
    $targetStream = New-Object -TypeName System.IO.FileStream -ArgumentList $targetFile, Create 
    $buffer = new-object byte[] 10KB 
    $count = $responseStream.Read($buffer,0,$buffer.length) 
    $downloadedBytes = $count 
    $totalLengthMB = [System.Math]::Floor($totalLength / 1024)
    while ($count -gt 0) 
    { 
        $downloadedMB = [System.Math]::Floor($downloadedBytes/1024/1024)
        $percentageComplete = $([System.Math]::Round([System.Math]::Floor($downloadedBytes/1024) / $totalLength * 100,2))
        Write-Progress -Activity "Downloading File..." -Status "$percentageComplete% ($($downloadedMB)MB of $($totalLengthMB)MB) complete" -PercentComplete $percentageComplete
        # [System.Console]::CursorLeft = 0
        # [System.Console]::Write("Downloaded {0}K of {1}K", [System.Math]::Floor($downloadedBytes/1024), $totalLength) 
        $targetStream.Write($buffer, 0, $count) 
        $count = $responseStream.Read($buffer,0,$buffer.length) 
        $downloadedBytes = $downloadedBytes + $count 
    } 
    Write-Host "Finished Download"
    $targetStream.Flush()
    $targetStream.Close()
    $targetStream.Dispose()
    $responseStream.Dispose()
}

Write-Host "Downloading Erlang:"
DownloadFile -url $erlangUrl -targetFile $erlangTargetFile

Write-Host "Downloading RabbitMQ:"
DownloadFile -url $rabbitmqUrl -targetFile $rabbitmqTargetFile