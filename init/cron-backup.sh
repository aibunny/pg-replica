set -e

# Set up cron job to run incremental backup every hour
until
    sudo echo "0 * * * * root pgbackrest --stanza=aibunny --log-level-console=info --type=incr backup >> /var/log/cron.log 2>&1" > /etc/cron.d/incr-backup-cron
    sudo chmod 0644 /etc/cron.d/incr-backup-cron
do 
    echo "Setting up cron for incremental backup"
    sleep 1s
done
    echo 'cron for incremental backup has been set up'


# Set up cron job to run full backup every 1 am in the morning on saturdays
until
    sudo echo "0 1 * * 6 root pgbackrest --stanza=aibunny --log-level-console=info --type=full backup  >> /var/log/cron.log 2>&1" > /etc/cron.d/full-backup-cron
    sudo chmod 0644 /etc/cron.d/full-backup-cron
do 
    echo "Setting up cron for full backup"
    sleep 1s
done
    echo 'cron for full backup has been set up'
