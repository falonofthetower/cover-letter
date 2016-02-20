Fabricator(:history) do
  subject { Faker::Lorem.word }
  text { Faker::Lorem.paragraph(10) }
end

