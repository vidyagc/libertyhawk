class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :bill_id
      t.string :title
      t.text :summary
      t.string :date
      t.string :sponsor
      t.string :sponsor_state
      t.string :sponsor_party
      t.string :link
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
