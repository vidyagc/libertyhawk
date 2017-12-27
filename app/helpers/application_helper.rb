module ApplicationHelper
    
  def sort_test
    self.sort_by {|bill| bill.title}
  end 
    
end


