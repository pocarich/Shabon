class AddOriginIdToRepositories < ActiveRecord::Migration[6.0]
  def change
    add_column :repositories, :origin_id, :integer
  end
end
