FROM alpine:edge as builder

RUN apk update && \
    apk add --no-cache curl

RUN curl -Lo zig.tar.xz https://ziglang.org/download/0.16.0/zig-x86_64-linux-0.16.0.tar.xz
RUN mkdir zig && tar xvf zig.tar.xz -C zig --strip-components 1
ENV PATH $PATH:/zig

WORKDIR /build
COPY ./build.zig .
COPY ./src/main.zig ./src/

RUN zig build -Doptimize=ReleaseSafe

ENTRYPOINT [ "/build/zig-out/bin/ddsk" ]
