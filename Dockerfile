FROM jpillora/cloud-torrent
EXPOSE 8080
CMD ["--port", "8080"]
VOLUME /path/to/my/downloads:/downloads
ENTRYPOINT ["cloud-torrent"]