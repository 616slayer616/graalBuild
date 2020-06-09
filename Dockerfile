FROM gradle:jdk13

# Install Graal
# Prepare
RUN apt-get update && \
    apt-get install -y wget gcc libz-dev && \
    rm -rf /var/lib/apt/lists/*

ARG GRAAL_VERSION=20.1.0
ARG JDK_VERSION=11
RUN cd / && \
    wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAAL_VERSION/graalvm-ce-java$JDK_VERSION-linux-amd64-$GRAAL_VERSION.tar.gz && \
    tar -xzf graalvm-ce-java$JDK_VERSION-linux-amd64-$GRAAL_VERSION.tar.gz && \
    rm graalvm-ce-java$JDK_VERSION-linux-amd64-$GRAAL_VERSION.tar.gz && \
    /graalvm-ce-java$JDK_VERSION-$GRAAL_VERSION/bin/gu install native-image

ENV PATH=/graalvm-ce-java$JDK_VERSION-$GRAAL_VERSION/bin:$PATH

# Install Docker
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" && \
   apt-get update && \
   apt-get install -y docker-ce-cli && \
   rm -rf /var/lib/apt/lists/* /var/cache/apt

# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || true && \
    apt update && \
    apt install -fy && \
    dpkg -i google-chrome-stable_current_amd64.deb && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt
