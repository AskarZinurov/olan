require "sequel"
Bundler.require(:default, ENV["OLAN_ENV"] || "production")

Sequel.extension :migration
Sequel.database_timezone = :utc

client = Sequel.connect("postgres://#{ENV["PG_USER"]}:#{ENV["PG_PASSWORD"]}@#{ENV["PG_HOST"]}/#{ENV["PG_DATABASE"]}")
Sequel::Migrator.run(client, "./db/migrations")