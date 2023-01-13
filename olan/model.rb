require "db/client"
require "db/postgres"
require "forwardable"

module Olan
  module Model
    def self.connection
      @connection ||= DB::Client.new(
        DB::Postgres::Adapter.new(
          database: ENV["PG_DATABASE"],
          username: ENV["PG_USER"],
          password: ENV["PG_PASSWORD"],
          host: ENV["PG_HOST"],
          port: ENV["PG_PORT"]
        )
      )
    end

    def with_session
      session = Model.connection.transaction
      result = yield(session)
      session.commit
      result
    rescue StandardError => e
      session&.abort
      raise e
    ensure
      session&.close
    end

    def self.extended(base)
      base.extend Forwardable
      base.def_delegator :'self.class', :with_session
    end
  end
end
