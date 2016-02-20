Fabricator(:reason) do
  header { Faker::App.name }
  text { Faker::Lorem.paragraph(1) }
end
