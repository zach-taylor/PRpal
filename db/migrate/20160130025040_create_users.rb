class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :email
      t.string :name
      t.string :token
      t.string :token_scopes, array: true
      t.string :github_username
      t.integer :github_uid, index: true, null: false, unique: true

      t.timestamps
    end
    add_index :users, :token_scopes, using: 'gin'
  end
end
