class History < ActiveRecord::Base
  validates_presence_of :subject
  validates_presence_of :text
end
