require 'rails_helper'

describe History do
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:text) }
end
