class CreateSubjectSearches < ActiveRecord::Migration
  def change
    create_table :subject_searches do |t|
      t.string :metadata

      t.timestamps null: false
    end
  end
end
