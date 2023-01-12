Sequel.migration do
    up do 
        run 'CREATE EXTENSION "uuid-ossp"'
        create_table(:events) do
            column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
            Integer :number, default: 0
        end
    end

    down do 
        run 'DROP EXTENSION "uuid-ossp"'
        drop_table :events
    end
end