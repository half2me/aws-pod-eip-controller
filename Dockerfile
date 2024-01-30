FROM golang:alpine as builder

WORKDIR /workspace

COPY go.mod go.sum ./
RUN go mod download
COPY . .
ENV GOCACHE=/root/.cache/go-build
RUN --mount=type=cache,target="/root/.cache/go-build" go build

FROM alpine

COPY --from=builder /workspace/aws-pod-eip-controller /usr/local/bin/aws-pod-eip-controller
CMD ["aws-pod-eip-controller"]
