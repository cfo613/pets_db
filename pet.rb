require 'sqlite3'
# http://www.rubydoc.info/gems/sqlite3/1.3.10
require 'pry'
# select a database, or create it if it does not yet exist
db = SQLite3::Database.new "pets.db"

#ask user what they would like to do
puts "what would you like to do? (C)reate, (R)ead, (U)pdate, or (D)estroy?"
response = gets.chomp.downcase

if response == "c"
  puts "please provide pet name"
  name = gets.chomp.downcase
  puts "please provide pet type"
  type = gets.chomp.downcase
  db.execute("INSERT INTO pets (name, type) VALUES(?, ?)", name, type)
  pet = db.execute("SELECT name, type FROM pets WHERE ID = (SELECT MAX(ID) FROM pets)")
  puts pet[0][0].capitalize + "the " + pet[0][1] + " has been added to the pet database."
end

if response == "r"
  all_pets = db.execute("SELECT * FROM pets")
  all_pets.each do |entry|
    puts entry[1].capitalize + " the " + entry[2] + " has ID: " + entry[0].to_s + " and was last updated " + entry[4]
  end
end

if response == "u"
  all_pets = db.execute("SELECT * FROM pets")
  all_pets.each do |entry|
    puts entry[1].capitalize + " the " + entry[2] + " has ID: " + entry[0].to_s + " and was last updated " + entry[4]
  end
  puts "enter the ID of the pet you would like to update"
  id = gets.chomp.to_i
  puts "what is the pet's new name?"
  new_name = gets.chomp
  db.execute("UPDATE pets SET name = #{new_name} WHERE ID = #{id}")
  update_pet = db.execute("SELECT * FROM pets WHERE ID = #{id}")
end

if response == "d"
  all_pets = db.execute("SELECT * FROM pets")
  all_pets.each do |entry|
    puts entry[1].capitalize + " the " + entry[2] + " has ID: " + entry[0].to_s + " and was last updated " + entry[4]
  end
  puts "enter the ID of the pet you would like to delete"
  id = gets.chomp
  db.execute("DELETE from pets WHERE ID = #{id}")
  puts "but whhhyyy?"
end
