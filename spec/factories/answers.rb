FactoryBot.define do
  factory :answer do
    body { "This is a valid answer body that is long enough to pass the minimum length validation." }
    association :question
  end
end
