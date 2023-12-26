# ----------------------------------
# Sparked Host Custom Image
# Image: ghcr.io/sparkedhost/images:mcc
# ----------------------------------

# Using the .NET official image for .NET 6.0
FROM        mcr.microsoft.com/dotnet/sdk:6.0

LABEL       author="DevOps Team at Sparked Host" maintainer="sysadmin@sparkedhost.com"

RUN apt-get update -y \
 && apt-get install -y jq unzip curl \
 && useradd -d /home/container -m container \
 && apt-get update

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh

RUN         chmod +x /entrypoint.sh
USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
