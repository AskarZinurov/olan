require "spec_helper"
require "securerandom"

describe Olan::Service do
  let(:id) { SecureRandom.uuid }
  let(:number) { rand(100) }

  extend Olan::Model

  after do
    with_session do |c|
      c.query("TRUNCATE TABLE events").call
    end
  end

  around do |task|
    Sync do
      task.run
    end
  end

  let(:service) { described_class.new(id: id, number: number) }
  subject(:call) { service.call }

  it "summarizes num value" do
    expect(call).to eq("id" => id, "number" => number)
    expect(described_class.new(id: id, number: number).call).to eq("id" => id, "number" => number)
    expect(described_class.new(id: nil, number: 123).call).to eq("id" => id, "number" => number)
    expect(described_class.new(id: id, number: 123).call).to eq("id" => id, "number" => number)

    new_id = SecureRandom.uuid
    new_number = 42
    expect(described_class.new(id: new_id, number: new_number).call).to eq("id" => new_id, "number" => number + new_number)
    expect(described_class.new(id: new_id, number: 44444).call).to eq("id" => new_id, "number" => number + new_number)
  end

  context "when event id is empty" do
    let(:id) { nil }

    it "returns current amount" do
      expect(call).to eq("id" => nil, "number" => nil)
    end
  end
end
