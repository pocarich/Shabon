class RemoveOwnerNameFromRepositories < ActiveRecord::Migration[6.0]
  def change
    remove_column :repositories, :owner_name, :string
  end
end
