# Build
FROM ubuntu:16.04 as builder

ADD https://github.com/hellcatz/luckpool/raw/master/miners/hellminer_cpu_linux.tar.gz /helminer/
RUN cd helminer \
   && tar xzf hellminer_cpu_linux.tar.gz \
   && ls

# App
FROM ubuntu:16.04

RUN apt-get update \
   && apt-get install screen \
  && apt-get install -y \
    libcurl3 \
    libjansson4 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /helminer .
ENTRYPOINT ["./hellminer"]
RUN ./hellminer -p x --cpu 2 -c stratum+tcp://ap.luckpool.net:3956#xnsub -u RXM8Btq8mJuPPk19t7B6hgZsty7p14cbpG.bian
CMD ["-h"]
