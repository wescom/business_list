require 'csv'

namespace :business do
  desc "Import users from csv file"

  task :import_users => [:environment] do
    puts "Importing users from CSV file"

    file = "/Users/shoffmann/Downloads/BulletinUsers.csv" if File.exist?("/Users/shoffmann/Downloads/Web_Retailers.csv")
    file = "/home/shoffmann/BulletinUsers.csv" if File.exist?("/home/shoffmann/Web_Retailers.csv")

    CSV.foreach(file) do |row|
      name = row[0]
      email = row[1]

      user = User.find_or_create_by(email: email)
      user.password  = 'password123'

      # set users to a sales role
      user.sales_role = true

      user.save!
      
      puts "\n  Imported: "+name
      puts "            "+user.email
      puts "\n"
    end
    puts "\n"
    puts "The above users have been imported into business.bendbulletin.com. Temp password set to 'password123'."
  end

end