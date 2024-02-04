FROM ubuntu:latest

# Installing needed soft
RUN apt-get update -y && \
    apt-get -y install curl unzip vim && \
    curl https://rclone.org/install.sh | bash

# Adding user collector
RUN groupadd -g 999 collector && \
    useradd -r -u 999 -g collector collector

# Adding scripts and rsync conf
COPY ./run.sh /home/collector/run.sh
COPY ./rclone.conf /home/collector/.config/rclone/rclone.conf

RUN chmod +x /home/collector/run.sh
RUN chmod +x /home/collector/.config/rclone/rclone.conf

USER collector
CMD ["sh", "-c", "/home/collector/run.sh"]