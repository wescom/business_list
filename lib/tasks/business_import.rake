require 'csv'

namespace :business do
  desc "Import businesses from csv file"
  puts "Importing businesses from CSV file"

  task :import => [:environment] do
    file = "/Users/shoffmann/Downloads/Web Retailers.csv"
    business_type = "Retail"

    CSV.foreach(file) do |row|
      if !row[1].nil? && row[1] != "Restaurant" && row[1] != "Business"
        logo = row[0]
        name = row[1]
        business_subtype = row[2]
        location = row[3]
        phone = row[4]
        website = row[5]
        service_type = row[6]
        city = row[7]
        
        name = name.gsub("  "," ")
        
        business = Business.find_or_create_by(name: name, city: city)
        business.business_type = BusinessType.find_by(name: business_type)
        business.address1 = location
        business.phonenum = phone
        business.website = website

        unless service_type.nil?
          service_type = service_type.downcase.gsub("pick up", "Pickup")
          service_type = service_type.downcase.gsub("pickup", "Pickup")
          service_type = service_type.downcase.gsub("pickup curbside", "Pickup")
          service_type = service_type.downcase.gsub("delivery", "Delivery")
          business.service_type = ServiceType.find_by(name: service_type)
          if business.service_type.nil?
            puts "        *** service_type not found: "+service_type
          end
        end
        
        business.save!
        
        puts "  Imported: "+name
      end
    end
  end
        
  import
end