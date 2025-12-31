FROM mysterysd/wzmlx:v3

WORKDIR /usr/src/app

RUN chmod 777 /usr/src/app
RUN uv venv --system-site-packages

# Install Go and build custom rclone
RUN apt-get update && apt-get install -y golang-go git && \
    rm -rf /var/lib/apt/lists/*

# Build rclone from drime branch
RUN git clone https://github.com/rclone/rclone.git /tmp/rclone && \
    cd /tmp/rclone && \
    git checkout drime && \
    go build -o /usr/local/bin/ghostdrive && \
    cd / && rm -rf /tmp/rclone

COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
