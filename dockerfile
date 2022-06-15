FROM golang:1.16

ENV CGO_ENABLED=1
ENV GOPROXY=https://goproxy.cn,direct
ENV GOOS=linux
ENV GOARCH=arm
ENV CC=arm-linux-gnueabi-gcc
ENV LD_LIBRARY_PATH=/usr/arm-linux-gnueabi/lib/
RUN apt-get update
RUN apt-get install gcc-arm-linux-gnueabi -y

WORKDIR /app

COPY . .

RUN arm-linux-gnueabi-gcc  -fPIC -shared -o lib/libadd.so ./include/add.c

RUN ln -s /usr/arm-linux-gnueabi/lib/ld-linux.so.3 /lib/ld-linux.so.3
RUN go build -o main main.go
RUN export LD_LIBRARY_PATH=/usr/arm-linux-gnueabi/lib/
RUN echo $LD_LIBRARY_PATH
CMD ["./main"]
