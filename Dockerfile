FROM mysterysd/wzmlx:v3

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
RUN uv venv --system-site-packages

# Replace ghostdrive with drime rclone
COPY ./rclone-drime /usr/local/bin/ghostdrive
RUN chmod +x /usr/local/bin/ghostdrive

COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
