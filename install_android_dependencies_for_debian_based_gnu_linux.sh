#!/usr/bin/env bash

## DEPENDENCIES
sudo apt update
sudo apt upgrade
sudo apt install -y git lib32z1 libssl-dev pkg-config build-essential curl cmake openjdk-11-jdk zip unzip
# if there are any error loading the above, re-run apt update and address them before continuing!
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

##CLONE SPRUCE REPOSITORIES
git clone https://github.com/spruceid/didkit
git clone https://github.com/spruceid/credible
git clone --recursive https://github.com/spruceid/ssi

##FLUTTER
git clone https://github.com/flutter/flutter.git -b dev $HOME/flutter
echo 'export PATH=$HOME/flutter/bin:"$PATH"' >> $HOME/.bashrc 

##ANDROID SDK AND NDK
cd $HOME
wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip sdk-tools-linux-4333796.zip -d Android
rm sdk-tools-linux-4333796.zip
wget https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
unzip commandlinetools-linux-6200805_latest.zip -d Android/cmdline-tools
rm commandlinetools-linux-6200805_latest.zip
echo 'export ANDROID_SDK_ROOT=$HOME/Android' >> $HOME/.bashrc
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> $HOME/.bashrc
echo 'export PATH=$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:"$PATH"' >> $HOME/.bashrc
echo 'export PATH=$ANDROID_SDK_ROOT/cmdline-tools/tools/lib:"$PATH"' >> $HOME/.bashrc
echo 'export PATH=$ANDROID_SDK_ROOT/tools:"$PATH"' >> $HOME/.bashrc
echo 'export PATH=$JAVA_HOME/bin:"$PATH"' >> $HOME/.bashrc
. $HOME/.bashrc
sdkmanager --sdk_root=$ANDROID_SDK_ROOT --install "system-images;android-29;google_apis;x86" "system-images;android-29;google_apis;x86_64" "platform-tools" "platforms;android-29" "build-tools;29.0.3" "ndk;22.0.7026061" "cmdline-tools;latest"
sdkmanager --licenses

##ANDROID EMULATOR
curl -s "https://get.sdkman.io" | bash 
. .sdkman/bin/sdkman-init.sh
sdk install gradle 6.5.1
echo "no" | avdmanager --verbose create avd --force --name "generic_10" --package "system-images;android-29;google_apis;x86" --tag "google_apis" --abi "x86"

##BUILD DIDKIT
printf "You are now ready to run the following commands, but re-loading bash/OS may be necessary. 
If rustup is inaccessible, reboot/re-load bash.
$ cd didkit
$ make -C lib install-rustup-android
$ make -C lib ../target/test/java.stamp
$ make -C lib ../target/test/aar.stamp
$ make -C lib ../target/test/flutter.stamp
$ cargo build\n\n"
