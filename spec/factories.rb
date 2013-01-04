FactoryGirl.define do
  factory :player do
    name     "Sweet and Evil"
    email    "sweet@evil.com"
    bio      "We are good boys"
    password "feedmenow"
    password_confirmation "feedmenow"
  end
end