class Project < ActiveRecord::Base
  validates_presence_of :image_path
  validates_presence_of :text
end
