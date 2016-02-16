require 'rails_helper'

RSpec.describe Project do
  it { should validate_presence_of(:image_path) }
  it { should validate_presence_of(:text) }
end
