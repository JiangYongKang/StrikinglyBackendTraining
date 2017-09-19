# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..3).each do |i|
  Dept.create(name: "dept_#{i}")
end

(1..10).each do |i|
  User.create(name: "user_#{i}", dept_id: i % 3 + 1)
end
