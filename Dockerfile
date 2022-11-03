FROM python:3.11.0-alpine3.16

# Speedtest CLI Version
ARG SPEEDTEST_VERSION=1.2.0

WORKDIR /app
COPY src/requirements.txt .

# Install required modules and Speedtest CLI
RUN pip install --no-cache-dir -r requirements.txt && \
    wget -nv -O speedtest.tgz "https://install.speedtest.net/app/cli/ookla-speedtest-${SPEEDTEST_VERSION}-linux-aarch64.tgz" && \
    tar zxvf speedtest.tgz && \
    cp speedtest /usr/local/bin

COPY src/. .

EXPOSE 9798

CMD ["python", "-u", "exporter.py"]

HEALTHCHECK --timeout=10s CMD wget --no-verbose --tries=1 --spider http://localhost:9798/
