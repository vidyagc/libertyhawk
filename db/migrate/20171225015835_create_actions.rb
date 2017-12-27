class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :action_id
      t.string :chamber
      t.string :action_type
      t.string :date
      t.text :description

      t.timestamps null: false
    end
  end
end
