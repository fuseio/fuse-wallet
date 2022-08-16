#!/usr/bin/env bash

if [[ "$*" != *-android* ]] && [[ "$*" != *-ios* ]]; then
  echo -e "\033[0;31mAt least one of the following arguments are required to build didkit:\033[0m
    \033[0;36m-android\033[0m: builds didkit's Android binaries
    \033[0;36m-ios\033[0m: builds didkit's iOS binaries
"
  exit
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Checking for brew installation."
  if ! command -v brew &>/dev/null; then
    echo -e "\033[0;Could not find brew, please install brew or add it to path.\033[0m"
    exit
  fi
fi

echo "Checking for rustup installation and setting rust to nightly."
if ! command -v rustup &>/dev/null; then
  if ! command -v curl &>/dev/null; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      brew install curl
    else
      sudo apt install curl -yet
    fi
  fi

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup default nightly
fi

if [[ "$*" == *-android* ]]; then
  echo "Checking for java installation."

  if ! command -v javac &>/dev/null; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      brew install openjdk
    else
      sudo apt install default-jdk
    fi
  fi
fi

echo "Cloning DIDKit repo if not yet on previous directory"
[ ! -d "../didkit" ] && git clone https://github.com/spruceid/didkit.git ../didkit

echo "Cloning SSI repo if not yet on previous directory"
[ ! -d "../ssi" ] && git clone https://github.com/spruceid/ssi.git --recurse-submodules ../ssi

if [[ "$*" == *-android* ]]; then
  echo "Checking for android sdk."
  [ ! -d "$ANDROID_SDK_ROOT" ] && echo -e "\033[0;31mFailed to find Android SDK\033[0m" && exit
  [ ! -d "$ANDROID_SDK_ROOT/build-tools" ] && [ ! -d "$ANDROID_TOOLS" ] && echo -e "\033[0;31mFailed to find android-tools\033[0m" && exit
  [ ! -d "$ANDROID_SDK_ROOT/ndk" ] && [ ! -d "$ANDROID_NDK_HOME" ] && echo -e "\033[0;31mFailed to find Android NDK\033[0m" && exit
fi

if ! command -v flutter &>/dev/null; then
  echo -e "\033[0;Could not find Flutter, please install flutter or add to path.\033[0m"
  exit
fi

flutter channel dev
flutter upgrade

if [[ "$*" == *-android* ]]; then
  flutter doctor --android-licenses
fi

cd ../didkit

if [[ "$*" == *-android* ]]; then
  echo "Build didkit for Android"
  make -C lib install-rustup-android
  make -C lib ../target/test/aar.stamp
fi

if [[ "$*" == *-ios* ]]; then
  echo "Build didkit for iOS"
  make -C lib install-rustup-ios
  make -C lib ../target/test/ios.stamp
fi

cargo build
