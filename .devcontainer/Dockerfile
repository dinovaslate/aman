FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Tools
RUN apt-get update && apt-get install -y \
    curl unzip git xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Java (for Android toolchain tasks)
RUN apt-get update && apt-get install -y openjdk-17-jdk && rm -rf /var/lib/apt/lists/*

# Flutter SDK
ENV FLUTTER_HOME=/opt/flutter
RUN git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Android SDK (build only; emulator usually unavailable in Codespaces)
ENV ANDROID_SDK_ROOT=/opt/android-sdk
RUN mkdir -p $ANDROID_SDK_ROOT && \
    curl -fsSL https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -o /tmp/clt.zip && \
    unzip -q /tmp/clt.zip -d /opt/android-sdk && \
    mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    mv /opt/android-sdk/cmdline-tools/* $ANDROID_SDK_ROOT/cmdline-tools/latest/ || true && \
    yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses || true && \
    $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

ENV PATH="${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/build-tools/34.0.0:${PATH}"

# Pre-warm Flutter
RUN flutter config --no-analytics && flutter precache --web
