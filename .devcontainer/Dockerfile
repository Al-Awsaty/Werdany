# Base image with Flutter
FROM cirrusci/flutter:stable

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    zip \
    bash \
    curl \
    wget \
    lib32stdc++6 \
    libglu1-mesa \
    && apt-get clean

# Set up Android SDK
RUN mkdir -p /usr/local/android-sdk
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

# Install Flutter dependencies
RUN flutter precache && flutter config --enable-web

# Clean up
RUN apt-get autoremove -y && apt-get clean

# Set working directory
WORKDIR /workspace
