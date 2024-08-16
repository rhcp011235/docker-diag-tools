FROM debian:bookworm-slim
LABEL Name=docker-iperf3-speedtest-graph
LABEL maintainer="John Hale"

RUN apt update && apt full-upgrade -y

# Lets install our needed packages
RUN apt install -y apt-utils bash curl iputils-ping iperf3 iproute2 speedtest-cli procps python3 python3-pip \
net-tools netcat-openbsd vnstat mtr traceroute tcptraceroute openssh-client openssl tcpdump dnsutils wget gnupg mosquitto-clients cron
    
RUN apt clean && apt autoremove -y

# Add crontab file
COPY crontab /etc/cron.d/crontab

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Start the cron service
CMD cron && tail -f /var/log/cron.log

# Install the python version of iperf3
CMD pip install iperf3



ENTRYPOINT ["/bin/sleep", "999d"]
