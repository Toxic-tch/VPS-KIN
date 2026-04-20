FROM ubuntu:24.04

ENV container docker
ENV DEBIAN_FRONTEND=noninteractive

# Install systemd + shellinabox
RUN apt-get update && \
    apt-get install -y systemd systemd-sysv shellinabox sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set root password (change if needed)
RUN echo "root:root" | chpasswd

# Enable shellinabox
RUN sed -i 's/--no-beep/--no-beep --service=/:LOGIN/' /etc/default/shellinabox || true

# Expose shellinabox
EXPOSE 4200

# Systemd entrypoint
STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init"]
