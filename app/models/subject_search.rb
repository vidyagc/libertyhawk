class SubjectSearch < ActiveRecord::Base
    #serialize :data, Hash
    belongs_to :user
end
