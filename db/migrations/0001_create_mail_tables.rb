Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String      :username,  :null => false
      String      :domain,    :null => false
      String      :password,  :null => false
      timestamptz :created_at
      timestamptz :updated_at

      index :username
      index :domain
    end

    create_table(:domains) do
      primary_key :id
      String      :domain,    :null => false, :unique => true
      timestamptz :created_at
      timestamptz :updated_at

      index :domain
    end

    create_table(:aliases) do
      primary_key :id
      String      :source,      :null => false
      String      :destination, :null => false
      timestamptz :created_at
      timestamptz :updated_at

      index :source
      index :destination
    end
  end
end
