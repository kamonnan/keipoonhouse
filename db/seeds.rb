User.destroy_all

[
  "Kate",
  "Bella",
  "Finn",
  "Gee",
  "Giselle",
  "Kass"
].each do |name|
  User.create!(name: name)
end
