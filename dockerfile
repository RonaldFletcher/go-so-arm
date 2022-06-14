FROM  golang:1.17.9-alpine AS builder
WORKDIR /app
COPY . .
#编译
RUN GOOS=linux CGO_ENABLED=1 GOARCH=arm64 go build -o main main.go
FROM alpine
WORKDIR /app
COPY --from=builder /app/main  .

CMD ["./main"]
