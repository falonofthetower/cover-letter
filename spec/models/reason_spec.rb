require 'rails_helper'

RSpec.describe Reason do
  it { should validate_presence_of(:header) }
  it { should validate_presence_of(:text) }
end
