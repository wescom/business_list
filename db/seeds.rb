# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating Business_Types...'
BusinessType.create(name: 'Retail', title_for_subtypes: 'Business Type')
puts '   created businesstype: Retail'
@business_type = BusinessType.where('name = ?', 'Retail').first
types = ["Clothing","Toys","Auto","Jewelry","Gifts","Hair","Candy","Banking","Mortgage","Theatre","Gallery","Shoes","Books","Antiques","Hotel","Media"]
types.each do |type|
  BusinessSubtype.create(business_type_id: @business_type.id, name: type)
  puts '           subtype: '+type
end


BusinessType.create(name: 'Restaurant', title_for_subtypes: 'Cuisine')
puts '   created businesstype: Restaurant'
@business_type = BusinessType.where('name = ?', 'Restaurant').first
types = ["Mexican","Italian","Thai","Chinese","Greek","American","Hawaiian","Indian","Japanese","Pizza","Coffee","Tea","Pub"]
types += ["Barbeque","Donuts","Deli","Bakery","Vietnemese","Mediterranean","Ice Cream / Yogurt","German","Fusion","Mongolian"]
types += ["Middle Eastern","Cupcakery","Cuban","Brewery"]
types.each do |type|
  BusinessSubtype.create(business_type_id: @business_type.id, name: type)
  puts '           subtype: '+type
end
puts ''

puts 'Creating Service_Types...'
service_types = ['Pickup','Delivery','Both']
service_types.each do |servicetype|
  ServiceType.create(name: servicetype)
  puts '   servicetype: '+servicetype
end

puts ''

# Initialize first account:
User.create! do |u|
    u.email     = 'admin@bendbulletin.com'
    u.password    = 'password123'
    u.admin_role = true
    puts 'Create initial superadmin user: admin@bendbulletin.com, password123'
end

