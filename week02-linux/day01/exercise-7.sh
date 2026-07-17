# ==============================
# Bonus Exercise – sed
# ==============================
"
A deployment script generated a configuration file with placeholder values. Before deploying the application, you need to update the configuration using sed.

config.yml:
environment: dev
region: us-west-1
bucket: temp-bucket
debug: true
log_level: DEBUG
database: old-db
"

tldr sed

# Update the environment from dev to production
sed 's/environment: dev/environment: production/' config.yml

"
: dev/environment: production/' config.yml
environment: production
region: us-west-1
bucket: temp-bucket
debug: true
log_level: DEBUG
database: old-db
"

# Disable debug mode.
sed -i 's/debug: true/debug: false/' config.yml
"
bucket: temp-bucket
debug: false
log_level: DEBUG
database: old-db
"

# Renamethe s3 bucket
sed -i 's/bucket: temp-bucket/bucket: platform-data-prod/' config.yml
"
environment: dev
region: us-west-1
bucket: platform-data-prod
debug: true
log_level: DEBUG
database: old-db
"

# Change the logging level.
sed -i 's/log_level: DEBUG/log_level: INFO/' config.yml
"
environment: dev
region: us-west-1
bucket: temp-bucket
debug: true
log_level: INFO
database: old-db
"

# Change the logging level.
sed -i 's/log_level: DEBUG/log_level: INFO/' config.yml
"
environment: dev
region: us-west-1
bucket: temp-bucket
debug: true
log_level: INFO
database: old-db
"

# Update the database name.

sed -i 's/database: old-db/database: platform-db/' config.yml
"
environment: dev
region: us-west-1
bucket: temp-bucket
debug: true
log_level: DEBUG
database: platform-db
"

# Instead of modifying the original file, create a new file
sed \
    -e 's/environment: dev/environment: production/' \
    -e 's/log_level: DEBUG/log_level: INFO/' \
    -e 's/debug: true/debug: false/' \
    -e 's/log_level: DEBUG/log_level: INFO/'\
    -e 's/database: old-db/database: platform-db/' \
    config.yml > config-prod.yml

"
environment: production
region: us-west-1
bucket: temp-bucket
debug: false
log_level: INFO
database: platform-db
"

# Update multiple configuration files at once
touch \
    config-dev.yml \
    config-test.yml \
    config-prod.yml

echo "log_level: DEBUG" >  config-dev.yml
echo "log_level: DEBUG" >  config-test.yml
echo "log_level: DEBUG" >  config-prod.yml

sed -i 's/log_level: DEBUG/log_level: INFO/' \
    config-dev.yml \
    config-test.yml \
    config-prod.yml

