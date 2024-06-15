FROM kjuly/mkdocs-material:latest

LABEL org.opencontainers.image.authors="dev@kjuly.com" \
      org.opencontainers.image.licenses=MIT \
      org.opencontainers.image.source=https://github.com/swingapi/swing.kids \
      org.opencontainers.image.description="A Docker image to serve site: Swing Kids."

COPY entrypoint.sh /entrypoint.sh
COPY build.sh /build.sh
COPY serve.sh /serve.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "serve", "en", "0.0.0.0" ]
