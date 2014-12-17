# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :post do
    title       { Faker::Lorem.word }
    content     { Faker::Lorem.paragraph }
  end
end