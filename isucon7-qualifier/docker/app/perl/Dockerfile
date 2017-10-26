FROM perl:5.26

ARG GIT_URL=https://github.com/isucon/isucon7-qualify.git

RUN git clone $GIT_URL /home/isucon/isubata
WORKDIR /home/isucon/isubata/webapp/perl
RUN \
  rm cpanfile.snapshot && \
  curl -L https://cpanmin.us | perl - Carton && \
  carton install

EXPOSE 5000

ENTRYPOINT ["carton", "exec", "plackup", "-p", "5000", "app.psgi"]
CMD ["-s", "Starlet"]
