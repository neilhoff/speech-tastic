# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :product do
    title           { Faker::Lorem.word }
    description     { Faker::Lorem.paragraph }
    image_url       { Faker::Company.logo}
    link            { Faker::Internet.url}
    category        { "Lesson Plan"}
    kind           { "teachers pay teachers"}
  end
end