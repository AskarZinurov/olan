require_relative "model"

module Olan
  class Service
    extend Model

    attr_reader :id, :number

    def initialize(id: nil, number: nil)
      @id = id
      @number = number.to_i
    end

    def call
      if id
        record_result
      else
        current_result
      end
    end

    private

    def parse(result)
      Hash[result.field_names.zip(result.to_a.flatten)]
    end

    def current_result
      with_session do |conn|
        conn.query(<<~SQL).call.then { |result| parse(result) }
          SELECT DISTINCT ON (created_at) id, number FROM events ORDER BY created_at DESC LIMIT 1
        SQL
      end
    end

    def record_result
      with_session do |conn|
        conn.query(<<~SQL, id: id, number: number).call.then { |result| parse(result) }
          WITH new_row AS (
            INSERT INTO events (id, number)
            SELECT %{id}, 
              coalesce((SELECT DISTINCT ON (created_at) number FROM events ORDER BY created_at DESC LIMIT 1), 0) + %{number}
            WHERE NOT EXISTS (SELECT * FROM events WHERE id = %{id})
            RETURNING id, number
          )
          SELECT * FROM new_row
          UNION
          SELECT id, number FROM events WHERE id = %{id}
        SQL
      end
    end
  end
end
