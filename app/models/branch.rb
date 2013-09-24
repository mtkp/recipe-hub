class Branch < ActiveRecord::Base
  belongs_to :collection
  belongs_to :recipe
end
