# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create({:name => "Tizzy", :age => 18, :birth_date => "April 1", :sex => "F", :color => "Tabby"})

Cat.create({:name => "Bobby", :age => 5, :birth_date => "January 20", :sex => "M", :color => "Ugly"})

