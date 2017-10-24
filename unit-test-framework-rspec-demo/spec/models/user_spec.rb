require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "first" do
    user = User.create!(name: 'vincent', email: 'vincent4502237@gmail.com')
    expect(User.first).to eq(user)
  end

  it "is invalid without user name" do
    user = User.new(name: "", email: "")
    expect(user).not_to be_valid
  end

  it "is invalid without user email" do
    user = User.new(name: "", email: "")
    expect(user).not_to be_valid
  end
end
