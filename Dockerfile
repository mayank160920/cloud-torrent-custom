FROM jpillora/cloud-torrent

EXPOSE 8080

CMD ["--port", "8080"]

VOLUME /path/to/my/downloads:/downloads

CMD ["-p", "8080", ":", "8080", "-v", "/path/to/my/downloads", ":" ,"/downloads", "jpillora/cloud-torrent"]
