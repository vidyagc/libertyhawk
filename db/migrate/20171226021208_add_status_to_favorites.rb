class AddStatusToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :status, :boolean
  end
end
