FROM golang:1.12 as builder
WORKDIR /go/src/github.com/smartmachine/go-import-redirector
COPY . .
RUN go get -v ./...
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o go-import-redirector .
FROM alpine
COPY --from=builder /go/src/github.com/smartmachine/go-import-redirector/go-import-redirector /go-import-redirector
ENV PORT 8080
CMD ["/go-import-redirector", "-addr", ":$PORT", "go.smartmachine.io/*", "https://github.com/smartmachine/*"]
