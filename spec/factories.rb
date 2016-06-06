FactoryGirl.define do
  factory :link do
    title "MyString"
    url "MyString"
    read false
    user
  end

  factory :user do
    email "example@example.com"
    password "password"
  end
end
