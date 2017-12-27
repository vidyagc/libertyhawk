class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :chamber
      t.string :date
      t.string :time
      t.string :roll_call
      t.string :question
      t.string :result
      t.integer :yea
      t.integer :nay
      t.integer :not_voting
      t.string :api_url

      t.timestamps null: false
    end
  end
end
