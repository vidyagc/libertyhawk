class CreateSubjectSearches < ActiveRecord::Migration
  def change
    create_table :subject_searches do |t|
      t.text :metadata
      # t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
  
end
