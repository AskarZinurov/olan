#!/usr/bin/env -S falcon --verbose serve -c

require "db/client"
require "db/postgres"

class Olan
    CONNECTION = DB::Client.new(
        DB::Postgres::Adapter.new(
            database: ENV["PG_DATABASE"],
            username: ENV["PG_USER"],
            password: ENV["PG_PASSWORD"],
            host: ENV["PG_HOST"],
            port: ENV["PG_PORT"]
        )
    )

	def call(env)
        [200, {}, ["HELLO"]]
	end
end

run Olan.new

trap "SIGINT" do
  #Sync { application.close_all }
end
