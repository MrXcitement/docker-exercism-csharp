FROM debian:9
LABEL maintainer="mike@thebarkers.com" \
      description="An exercism 'csharp' track image." \
      version="0.1.1"

# Update, upgrade and install dev tools
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git procps tree vim wget 

# Install exercism tool
RUN cd /tmp \
    && wget https://github.com/exercism/cli/releases/download/v3.0.11/exercism-linux-64bit.tgz \
    && tar xzf exercism-linux-64bit.tgz \
    && mv exercism /usr/local/bin/

# Install dotnet dependencies
RUN apt-get update \
    && apt-get install -y pgp \
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg \
    && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ \
    && wget -q https://packages.microsoft.com/config/debian/9/prod.list \
    && mv prod.list /etc/apt/sources.list.d/microsoft-prod.list \
    && chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg \
    && chown root:root /etc/apt/sources.list.d/microsoft-prod.list

# Install dotnet
RUN apt-get install -y apt-transport-https \
    && apt-get update \
    && apt-get install -y dotnet-sdk-2.2

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/exercism

CMD ["bash", "--login"]
