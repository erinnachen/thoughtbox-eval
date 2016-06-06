require 'rails_helper'

RSpec.describe Link, type: :model do
  it {should validate_presence_of :title}
  it {should validate_presence_of :url}
  it {should belong_to :user}

  it "has a default value for read of false" do
    link = Link.new(title: "Hi", url: "enter url here")
    expect(link.read).to be false
  end

  it "should validate urls" do
    link = Link.new(title: "Hi", url: "enter url here")
    expect(link.valid?).to be false

    link = Link.new(title: "Hi", url: "http://www.google.com")
    expect(link.valid?).to be true
  end
end
