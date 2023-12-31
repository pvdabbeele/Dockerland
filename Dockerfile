FROM debian:bullseye-slim

# docker build --build-arg user=%REQUIRED_ACCOUNT% -t %IMAGE_NAME% -f %DOCKERFILE% .
# docker run -h %HOSTNAME% -it %IMAGE_NAME%

ARG user=guest

ENV LANG en_US.utf8
ENV TZ=Europe/Brussels
ENV user=${user}

USER root

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN useradd -U -m -s /bin/bash ${user}
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates dnsutils git netcat openssl traceroute wget

USER $user
WORKDIR /home/$user

ENTRYPOINT ["bash"]
