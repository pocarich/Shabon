class RemoveOwnerEmailFromRepositories < ActiveRecord::Migration[6.0]
  def change
    remove_column :repositories, :owner_email, :string
  end
end
