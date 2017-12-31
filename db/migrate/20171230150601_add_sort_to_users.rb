class AddSortToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sort, :string
  end
end
