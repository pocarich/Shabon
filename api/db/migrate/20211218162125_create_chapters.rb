class CreateChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :chapters do |t|
      t.references :repository, null: false, foreign_key: true
      t.string :title
      t.text :text
      t.integer :view
      t.integer :favorite

      t.timestamps
    end
  end
end
