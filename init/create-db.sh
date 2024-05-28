
#You might want to create adhoc databases on build
until
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL 
        CREATE DATABASE aibunny1;
        CREATE DATABASE aibunny2;

EOSQL

do
    echo "Creating dbs"
    sleep 1s
done
    echo 'dbs created'
