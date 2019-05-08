FROM mrbarker/exercism-base:0.1.1
LABEL maintainer="mike@thebarkers.com" \
      description="An exercism 'csharp' track image." \
      version="0.1.0"

RUN apt-get update \
    && apt-get install -y pgp \
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg \
    && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ \
    && wget -q https://packages.microsoft.com/config/debian/9/prod.list \
    && mv prod.list /etc/apt/sources.list.d/microsoft-prod.list \
    && chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg \
    && chown root:root /etc/apt/sources.list.d/microsoft-prod.list

RUN apt-get install -y apt-transport-https \
    && apt-get update \
    && apt-get install -y dotnet-sdk-2.2

WORKDIR /workspace

ENTRYPOINT ["bash"]
CMD ["--login"]
