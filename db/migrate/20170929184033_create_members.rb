class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :state
      t.string :first
      t.string :last
      t.integer :member_id

      t.timestamps null: false
    end
  end
end
