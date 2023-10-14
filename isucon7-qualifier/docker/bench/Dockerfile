FROM golang:1.9

COPY . /home/isucon/isubata
WORKDIR /home/isucon/isubata/bench
RUN \
  go get github.com/constabulary/gb/... && \
  gb vendor restore && \
  make

ENTRYPOINT ["bin/bench"]
CMD ["-remotes", "web"]
