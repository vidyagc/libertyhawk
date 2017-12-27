class Bill < ActiveRecord::Base
    belongs_to :user
    
def sort_test
    self.sort_by {|bill| bill.title}
end 
    
end
