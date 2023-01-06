FROM jpillora/cloud-torrent

COPY . /app

EXPOSE 63000

CMD ["--port", "63000"]

VOLUME /root/downloads:/downloads

ENV NAME=ct

CMD ["--name", "$NAME", "-d", "-p", "63000:63000", "--restart", "always", "-v", "/root/downloads:/downloads", "jpillora/cloud-torrent", "--port", "63000"]
