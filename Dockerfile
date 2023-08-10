FROM debian:bullseye-slim

# docker build --build-arg user=%REQUIRED_ACCOUNT% --name %TARGET_CONTAINER% -t %IMAGE_NAME -f %DOCKERFILE% .
# docker run -h %HOSTNAME% -it %TARGET_CONTAINER%

ARG user=guest

ENV LANG en_US.utf8
ENV TZ=Europe/Brussels
ENV user=${user}
ENV group=${user}

USER root

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN groupadd ${group}
RUN useradd -m -g ${group} -s /bin/bash ${user}
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates dnsutils git netcat openssl traceroute wget

USER $user
WORKDIR /home/$user

ENTRYPOINT ["bash"]
