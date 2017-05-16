FactoryGirl.define do
  factory :auction do
    title 'awesome title'
    details 'many description here'
    ends_on '10/10/2017'
    reserve_price 500
  end
end
