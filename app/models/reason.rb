class Reason < ActiveRecord::Base
  validates_presence_of :header
  validates_presence_of :text
end
