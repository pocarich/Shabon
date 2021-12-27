class ChangeNullAndDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :name, :string, null: false
    change_column :users, :email, :string, null: false

    change_column :repositories, :title, :string, null: false
    change_column_default :repositories, :view, 0
    change_column_default :repositories, :favorite, 0

    change_column :chapters, :title, :string, null: false
    change_column_default :chapters, :view, 0
    change_column_default :chapters, :favorite, 0
  end
end
