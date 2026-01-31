#!/bin/bash

# Install dependencies
sudo apt-get update
sudo apt-get install -y cmake python3 make perl unzip wget

# Install Android SDK and NDK
mkdir -p ~/android-sdk
cd ~/android-sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip
unzip cmdline-tools.zip -d .
mv cmdline-tools latest
mkdir cmdline-tools
mv latest cmdline-tools/
export ANDROID_SDK_ROOT=~/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin

# Accept licenses and install platforms, build-tools, NDK
yes | sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3" "ndk;23.1.7779620"  # برای اندروید 11 (API 30) به بالا

# Set environment variables
echo "export ANDROID_SDK_ROOT=~/android-sdk" >> ~/.bashrc
echo "export ANDROID_NDK_HOME=~/android-sdk/ndk/23.1.7779620" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/platform-tools:\$ANDROID_SDK_ROOT/cmdline-tools/latest/bin" >> ~/.bashrc
source ~/.bashrc

# Install Rust Android targets (فقط arm64 برای درخواستت)
rustup target add aarch64-linux-android
