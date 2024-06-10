set -e

until
    sudo pgbackrest --stanza=aibunny --log-level-console=info stanza-create
do
    echo "Creating pg_backrest stanza"
    sleep 1s
done
    echo 'stanza created'

sleep 60s

until
    sudo pgbackrest --stanza=aibunny --log-level-console=info backup
do
    echo "Starting initial backup"
    sleep 1s
done
    echo 'initial backup created'
