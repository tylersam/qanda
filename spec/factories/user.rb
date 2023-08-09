FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    first_name { 'John' }
    last_name { 'Doe' }
  end
end
