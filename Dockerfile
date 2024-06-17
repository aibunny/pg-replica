FROM postgres:latest

LABEL maintainer="aibunny"
# Create directory for sudoers.d if it doesn't exist
RUN mkdir -p /etc/sudoers.d

# Grant sudo privileges to postgres user without password
RUN echo 'postgres ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/postgres

# Install required packages
RUN apt-get update -y && apt-get install -y \
    wget build-essential git \
    curl ca-certificates \
    pkg-config libssl-dev pgbackrest \
    ca-certificates tzdata libxml2  sudo \
    libssh2-1 gosu openssh-client cron nano


# Clean up temporary files and dependencies
RUN apt-get purge -y git build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Create directories and set permissions for pgbackrest
RUN mkdir -p -m 750 \
    /var/log/pgbackrest \
    /var/lib/pgbackrest \
    /var/spool/pgbackrest \
    /etc/pgbackrest \
    /etc/pgbackrest/conf.d \
    /etc/pgbackrest/cert \
    /tmp/pgbackrest \
    /var/lib/postgresql/backups \
    /etc/cron.d \
    
  && chown -R postgres:postgres \
      /var/log/pgbackrest \
      /var/lib/pgbackrest \
      /var/spool/pgbackrest \
      /etc/pgbackrest \
      /tmp/pgbackrest \
      /var/lib/postgresql/backups \
      /etc/cron.d \

  && chmod 750 /var/log/pgbackrest

# Copy custom configuration files

# Healthcheck
HEALTHCHECK --interval=10s --timeout=5s --retries=5 \
    CMD pg_isready

# Expose the PostgreSQL port
EXPOSE 5432

USER postgres
# Start PostgreSQL with custom configuration
CMD ["postgres"]

