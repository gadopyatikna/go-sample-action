# --- Builder stage with Go
ARG GO_VERSION=1.22
FROM golang:${GO_VERSION}-bookworm AS builder

WORKDIR /app
COPY . .

# Install linters (golangci-lint is common)
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# --- Final stage
FROM debian:bookworm-slim

# Copy Go toolchain (optional: keep small, otherwise rebuild inside container)
COPY --from=builder /usr/local/go /usr/local/go
ENV PATH="/usr/local/go/bin:${PATH}"

# Copy linter
COPY --from=builder /go/bin/golangci-lint /usr/local/bin/

WORKDIR /workspace
ENTRYPOINT ["/go-action"]
