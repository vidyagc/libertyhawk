class AddStatusToBills < ActiveRecord::Migration
  def change
    add_column :bills, :status, :boolean
  end
end
