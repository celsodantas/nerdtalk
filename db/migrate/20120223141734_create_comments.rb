class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :email
      t.text :content
      t.references :proposal

      t.timestamps
    end
    add_index :comments, :proposal_id
  end
end
