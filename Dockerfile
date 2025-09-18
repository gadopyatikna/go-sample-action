# --- Builder stage with Go
ARG GO_VERSION=1.22
FROM golang:${GO_VERSION}-bookworm AS builder

WORKDIR /app
COPY . .
RUN go build -o /go-sample-action .

# --- Final stage
FROM debian:bookworm-slim

# Copy binary only (keeps image small)
COPY --from=builder /go-sample-action /go-sample-action

WORKDIR /workspace
ENTRYPOINT ["/go-sample-action"]
CMD ['build', 'test']