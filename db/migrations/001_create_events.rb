Sequel.migration do
  up do
    run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table(:events) do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      Integer :number, default: 0
      DateTime :created_at, default: Sequel.function(:now), null: false
    end
  end

  down do
    drop_table :events
    run 'DROP EXTENSION "uuid-ossp"'
  end
end
