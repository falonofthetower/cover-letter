Fabricator(:project) do
  image_path { Faker::App.name }
  text { Faker::Lorem.paragraph(3) }
end

