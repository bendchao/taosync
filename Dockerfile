FROM dr34m/pyinstaller:taosync as builder
WORKDIR /app
COPY . /app
RUN pyinstaller taoSync.spec

FROM alpine:3.20
VOLUME /app/data
WORKDIR /app
COPY --from=builder /app/dist/taoSync /app/
ENV TAO_EXPIRES=2 TAO_LOG_LEVEL=1 TAO_LOG_SAVE=7 TAO_TASK_SAVE=0 TAO_TASK_TIMEOUT=72
EXPOSE 8023
CMD ["./taoSync"]