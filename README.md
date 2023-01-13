Migrate database to latest version: `OLAN_ENV=development bundle exec ruby db/migrator.rb`

Rollback to specific version: `SCHEMA_VERSION=0 OLAN_ENV=development bundle exec ruby db/migrator.rb`

Start server: `bundle exec falcon host`

Install dependencies: `bundle install`

Test curl example: `curl -d "id=a85bf229-ba5b-4275-a3c7-b1e666c53ae4&number=13" -X POST http://localhost:3001`

Run specs (please note, specs are running on same database, so data loss can occur): `bundle exec rspec`

Before you start you need to set required env variables, which ones is mandatory you can find in `.env.example` file.
You can make this by defining yours `.env` file or by populating shell env.
