class CreateRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :repos do |t|
      t.integer :github_id, null: false, index: true
      t.boolean :active, default: false, null: false
      t.string :full_github_name, null: false
      t.integer :hook_id
    end
  end
end
