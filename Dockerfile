  FROM openjdk:8

  ENV SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
  ANDROID_HOME="/usr/local/android-sdk" \
  ANDROID_VERSION=28 \
  ANDROID_BUILD_TOOLS_VERSION=28.0.1

  # Download Android SDK
  RUN mkdir "$ANDROID_HOME" .android \
  && cd "$ANDROID_HOME" \
  && curl -o sdk.zip $SDK_URL \
  && unzip sdk.zip  \
  && rm sdk.zip \
  && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

  RUN $ANDROID_HOME/tools/bin/sdkmanager --update
  RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
  "platforms;android-${ANDROID_VERSION}" \
  "platform-tools"

  VOLUME ["/usr/local/android-sdk"]

  RUN mkdir /application
  WORKDIR /application

  ADD ./ /application

  COPY /home/ec2-user/api-6321041036636787156-617186-2030f42a00bb.json /application/app/

  RUN chmod +x gradlew