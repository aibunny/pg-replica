# Create replicator user and a physical replication slot

until
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOF
        DO \$\$
        BEGIN
            IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'replicator') THEN
                CREATE ROLE replicator WITH REPLICATION LOGIN PASSWORD '2024@aibunny';
            END IF;
        END
        \$\$;
        SELECT * FROM pg_create_physical_replication_slot('replication_slot');
EOF

do
    echo "Creating replication slot and replication role"
    sleep 1s
done
echo 'Replication user and slot created'
