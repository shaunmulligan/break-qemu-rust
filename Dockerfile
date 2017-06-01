FROM resin/raspberrypi3-debian:stretch 
#FROM resin/intel-nuc-debian:stretch
WORKDIR /root

RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates curl file \
    build-essential \
    autoconf automake autotools-dev libtool xutils-dev openssl

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain nightly -y

ENV PATH=/root/.cargo/bin:$PATH

RUN mkdir /.cargo

WORKDIR /rust
COPY . .
RUN cargo build -vv 

CMD ["./target/debug/break-qemu-rust"]