FROM python:3.11-slim

# Set a non‑root user for security
ARG UID=1000
ARG GID=1000
RUN addgroup --gid $GID appuser && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" appuser

# Install system dependencies (psycopg2 needs libpq-dev)
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY ./backend/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./backend ./

# Switch to non‑root user
USER appuser

EXPOSE 8000

