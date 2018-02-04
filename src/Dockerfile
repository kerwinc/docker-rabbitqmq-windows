#escape=`

FROM  microsoft/windowsservercore
LABEL maintainer="Kerwin Carpede"
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV ERLANG_HOME "C:\\Program Files\\erl9.0\\erts-9.0"
ENV ERLANG_SERVICE_MANAGER_PATH "C:\\Program Files\\erl9.0\\erts-9.0\\bin"

ADD tools c:\tools
RUN c:\tools\DownloadFiles.ps1 ; `
    c:\tools\Install.ps1 ; `
    c:\tools\Cleanup.ps1

ENV RABBITMQ_CONFIG_FILE "c:\\rabbitmq"
COPY rabbitmq.config start.ps1 c:\

EXPOSE 15672 4369 5671 5672 25672 35197

HEALTHCHECK --interval=5s --timeout=5s --start-period=10s --retries=10 `
  CMD powershell Invoke-WebRequest -Uri http://127.0.0.1:15672 -UseBasicParsing || exit 1

ENTRYPOINT ["powershell","c:\\start.ps1"]
CMD powershell