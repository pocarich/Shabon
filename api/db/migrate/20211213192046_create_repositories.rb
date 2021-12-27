class CreateRepositories < ActiveRecord::Migration[6.0]
  def change
    create_table :repositories do |t|
      t.string :title
      t.string :description
      t.text :detail
      t.string :owner_name
      t.string :owner_email
      t.integer :view
      t.integer :favorite

      t.timestamps
    end
  end
end
