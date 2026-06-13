FROM alpine:edge AS builder

RUN apk update && \
    apk add --no-cache curl

ARG ZIG_VERSION=0.16.0

RUN curl -Lo zig.tar.xz https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz
RUN mkdir zig && tar xvf zig.tar.xz -C zig --strip-components 1
ENV PATH=$PATH:/zig

WORKDIR /build
COPY ./build.zig .
COPY ./src/main.zig ./src/

RUN zig build -Doptimize=ReleaseSafe

FROM gcr.io/distroless/static-debian13

COPY --from=builder /build/zig-out/bin/ddsk /ddsk

ENTRYPOINT [ "/ddsk" ]
