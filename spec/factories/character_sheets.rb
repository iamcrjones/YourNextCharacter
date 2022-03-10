FactoryBot.define do
  factory :character_sheet do
    creator { nil }
    sheet_class { nil }
    sheet_race { nil }
    name { "MyString" }
    level { 1 }
    description { "MyString" }
  end
end
