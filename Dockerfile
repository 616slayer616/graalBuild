FROM oracle/graalvm-ce:latest
USER root
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -y --no-install-recommends \
		openssh-server \
		netcat-openbsd \
		git \
		nodejs \
	&& apt-get upgrade -y \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt

RUN ln -s "$(which nodejs)" /usr/local

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
