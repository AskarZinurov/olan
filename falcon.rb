#!/usr/bin/env -S falcon host
# frozen_string_literal: true

load :rack, :supervisor

ENV["HOSTNAME"] ||= "localhost"
ENV["APP_PORT"] ||= "3001"

hostname = File.basename(__dir__)
rack hostname do
  endpoint Async::HTTP::Endpoint.parse("http://#{ENV["HOSTNAME"]}:#{ENV["APP_PORT"]}").with(protocol: Async::HTTP::Protocol::HTTP1)

  count 3
end

supervisor
