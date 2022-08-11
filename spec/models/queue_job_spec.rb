require 'rails_helper'

RSpec.describe QueueJob, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  it "is valid with valid attributes" do
    expect(QueueJob.new).to be_valid
  end

  it "is not valid without a title" do
    obj = QueueJob.new(title: nil)
    expect(obj).to_not be_valid
  end

  it "is not valid without a priority" do
    auction = QueueJob.new(title: nil)
  expect(obj).to_not be_valid

  end
end
