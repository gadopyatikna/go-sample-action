# --- Builder stage with Go
ARG GO_VERSION=1.22
FROM golang:${GO_VERSION}-bookworm AS builder

WORKDIR /app
COPY . .
RUN go build -o /go-sample-action .

# --- Final stage
FROM debian:bookworm-slim

COPY --from=builder /usr/local/go /usr/local/go
ENV PATH="/usr/local/go/bin:${PATH}"

RUN go version

COPY --from=builder /go-sample-action /go-sample-action

WORKDIR /workspace
ENTRYPOINT ["/go-sample-action"]
CMD ['build', 'test']