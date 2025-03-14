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
types = ["General Retail","Clothing","Alcoholic Beverages","Appliances","Automotive Repair","Automotive Sales","Bike Shop"]
types += ["Books","Financial","Fitness","Garden","Golf","Hobbies/Crafts","Home Furnishings","Home improvement","Nail Salon"]
types += ["Religous Organization",'Shoes',"Sporting Goods","Styling Salons/Barber","Toys"]
types.each do |type|
  BusinessSubtype.create(business_type_id: @business_type.id, name: type)
  puts '           subtype: '+type
end


BusinessType.create(name: 'Restaurant', title_for_subtypes: 'Cuisine')
puts '   created businesstype: Restaurant'
@business_type = BusinessType.where('name = ?', 'Restaurant').first
types = ["American","Brewery","Fine Dining","Mediterranean","French","Chinese","Indian","Thai","Japanese","Sushi","Mexican"]
types += ["Casual Dining","Italian","French","Seafood","Middle Eastern","Peruvian","Tapas","Food Truck"]
types.each do |type|
  BusinessSubtype.create(business_type_id: @business_type.id, name: type)
  puts '           subtype: '+type
end
puts ''

puts 'Creating Service_Types...'
service_types = ['Pickup','Delivery','DineIn']
service_types.each do |servicetype|
  ServiceType.create(name: servicetype)
  puts '   servicetype: '+servicetype
end
puts ''

puts 'Creating Zones...'
zones = ['Bend','Redmond','Sisters','La Pine','Madras','Tumalo','Terrebonne','Warm Springs','Prineville','Summer Lake']
zones.each do |zone|
  Zone.create(name: zone)
  puts '   zone: '+zone
end
puts ''

# Initialize first account:
user = User.find_or_create_by(email: 'admin@bendbulletin.com')
if user
  user.password    = 'password123'
  user.admin_role = true
  user.save
  puts 'Create initial admin user: admin@bendbulletin.com, password123'
  puts user.inspect
end
puts ''

# Initialize default settings:
default_setting = DefaultSetting.first
if default_setting.nil?
  DefaultSetting.create(home_welcome_text: 'This is your welcome message',general_instructions: 'These are your general instructions',
    registration_text: 'This is your registration text')
  puts 'Create initial default setting record'
end
puts ''
