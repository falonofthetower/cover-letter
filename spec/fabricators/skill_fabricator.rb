Fabricator(:skill) do
  # added bitcoin address to assure random content for comparison
  title { Faker::App.name + Faker::Bitcoin.address }
  text { Faker::Lorem.paragraph(3) }
end

