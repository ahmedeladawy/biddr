FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Smith'
    email      'john@smith.com'
    password   'supersecret'
  end
end
