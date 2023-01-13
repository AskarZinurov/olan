require_relative "service"

module Olan
  class App
    def call(env)
      request_params = Hash[URI.decode_www_form(env['rack.input'].read)]
      service = Service.new(**request_params.slice("id", "number").transform_keys(&:to_sym))

      [200, {}, [service.call.to_json]]
    rescue => e
      [500, {}, [{ "error" => "ERROR: #{e.message}" }.to_json]]
    end
  end
end
