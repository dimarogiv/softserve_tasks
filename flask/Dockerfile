# syntax=docker/dockerfile:1
FROM python:3.10-alpine AS builder
WORKDIR /code
RUN apk add --no-cache \
      gcc musl-dev \
      linux-headers && \
      rm -rf /var/cache/apk/*

COPY requirements.txt requirements.txt
RUN pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt


FROM python:3.10-alpine
WORKDIR /code
COPY --from=builder /wheels /wheels
COPY requirements.txt .
RUN apk add --no-cache \
      mysql-client \
      mariadb-connector-c && \
      rm -rf /var/cache/apk/*

RUN pip install --no-cache-dir --no-index --find-links=/wheels \
      -r requirements.txt && rm -rf /wheels

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

EXPOSE 5000
COPY app.py .
CMD ["flask", "run", "--debug"]
