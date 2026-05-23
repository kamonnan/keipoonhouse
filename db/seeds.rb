User.destroy_all

[
  "Kate",
  "Bella",
  "Finn",
  "Gee",
  "Giselle",
  "Kassie"
].each do |name|
  User.create!(name: name)
end
