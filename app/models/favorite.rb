class Favorite < ActiveRecord::Base
  belongs_to :user
  
  validates :bill_id, uniqueness: { scope: :user_id, :message => "This bill is already saved." }
  
end
