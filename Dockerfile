FROM golang:1.16-alpine AS build
WORKDIR /app/
COPY . .
RUN CGO_ENABLED=0 go test ./...
RUN go build -o /bin/foundation *.go
EXPOSE 3000

FROM alpine:3.13.2
COPY --from=build /bin/foundation /bin/foundation
ENV PORT=8080
EXPOSE 8080
CMD ["/bin/foundation"]