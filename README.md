Migrate database to latest version: `OLAN_ENV=development bundle exec ruby db/migrator.rb`
Rollback to specific version: `SCHEMA_VERSION=0 OLAN_ENV=development bundle exec ruby db/migrator.rb`
Start server in dev mode (load env variables from .env file): `OLAN_ENV=development bundle exec falcon host`
Start server: `bundle exec falcon host`
Install dependencies: `bundle install`