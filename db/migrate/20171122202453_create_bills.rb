class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :bill_id
      t.string :title
      t.text :summary
      t.string :date
      t.string :sponsor
      t.string :sponsor_state
      t.string :sponsor_party
      t.string :link

      t.timestamps null: false
    end
  end
end
