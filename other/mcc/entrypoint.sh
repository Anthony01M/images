#!/bin/bash
cd /home/container

if [ -e "./MinecraftClient" -a -n "$MCC_SKIP_REDOWNLOAD" ]; then
  echo "Skip re-download MinecraftClient"
else
  # Use the provided version tag or get the latest release tag
  RELEASE_TAG=${MCC_VERSION:-$(curl -s -v https://github.com/MCCTeam/Minecraft-Console-Client/releases/latest 2>&1 | grep -i location: | tr -d '\r' | cut -d/ -f8)}

  # Delete the old build
  [ -e MinecraftClient-linux.zip ] && rm -- MinecraftClient-linux.zip
  [ -e MinecraftClient ] && rm -- MinecraftClient

  echo "Donwloading MinecraftClient for ${RELEASE_TAG}"

  # Download the specified build or the latest one
  curl -L https://github.com/MCCTeam/Minecraft-Console-Client/releases/download/${RELEASE_TAG}/MinecraftClient-linux.zip --output MinecraftClient-linux.zip

  # Unzip it
  unzip MinecraftClient-linux.zip

  # Remove the ZIP
  rm -- MinecraftClient-linux.zip
fi

# Make internal Docker IP address available to processes
export INTERNAL_IP=`ip route get 1 | awk '{print $(NF-2);exit}'`

# Set Executable
chmod +x ./MinecraftClient

# Replace Startup variables.
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "customer@apollopanel:~# ${MODIFIED_STARTUP}"

# Run the Server.
eval ${MODIFIED_STARTUP}
