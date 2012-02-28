class AddColumnOwnerHashToComment < ActiveRecord::Migration
  def change
    add_column :comments, :owner_hash, :string

  end
end
