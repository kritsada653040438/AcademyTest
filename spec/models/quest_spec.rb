require 'rails_helper'

RSpec.describe Quest, type: :model do
  it "is valid with valid attributes" do
    expect(build(:quest)).to be_valid
  end

  it "is not valid without a name" do
    quest = build(:quest, name: nil)
    expect(quest).to_not be_valid
  end

  it "is not valid with a name longer than 100 characters" do
    quest = build(:quest, name: "a" * 101)
    expect(quest).to_not be_valid
  end

  it "is not valid without a status" do
    quest = build(:quest, status: nil)
    expect(quest).to_not be_valid
  end

  it "is valid with status true" do
    quest = build(:quest, status: true)
    expect(quest).to be_valid
  end

  it "is valid with status false" do
    quest = build(:quest, status: false)
    expect(quest).to be_valid
  end
end
