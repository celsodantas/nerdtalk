class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :title
      t.text :description
      t.integer :votes, :default => 0

      t.timestamps
    end
  end
end
