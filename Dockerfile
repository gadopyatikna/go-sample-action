# --- Builder stage with Go
ARG GO_VERSION=1.22
FROM golang:${GO_VERSION}-bookworm AS builder

WORKDIR /app
COPY . .

# --- Final stage
FROM debian:bookworm-slim

# Copy Go toolchain (optional: keep small, otherwise rebuild inside container)
COPY --from=builder /usr/local/go /usr/local/go
ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR /workspace
ENTRYPOINT ["/go-sample-action"]

CMD ['build']