FactoryBot.define do
  factory :question do
    sequence(:title) { |n| "How to solve problem number #{n}? This is long enough." }
    body { "This is a detailed question body with enough characters to pass validation requirements." }
  end
end
