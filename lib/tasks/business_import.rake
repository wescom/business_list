require 'csv'

namespace :business do
  desc "Import businesses from csv file"

  task :import_retail => [:environment] do
    puts "Importing businesses from CSV file"

    file = "/Users/shoffmann/Downloads/Web_Retailers.csv" if File.exist?("/Users/shoffmann/Downloads/Web_Retailers.csv")
    file = "/home/shoffmann/Web_Restaurants.csv" if File.exist?("/home/shoffmann/Web_Restaurants.csv")
    business_type = "Retail"

    CSV.foreach(file) do |row|
      if !row[1].nil? && row[1] != "Restaurant" && row[1] != "Business"
        logo = row[0]
        name = row[1]
        business_subtypes = row[2]
        business_subtypes = cleanup_subtypes(row[2]).split(" ") unless business_subtypes.nil?
        location = row[3]
        phone = row[4]
        website = row[5]
        service_type = row[6]
        city = row[7]
        
        name = name.gsub("  "," ")
        
        business = Business.find_or_create_by(name: name, city: city)
        business.business_type = BusinessType.find_by(name: business_type)

        unless business_subtypes.nil?
          #puts "business_subtypes: "+business_subtypes.to_s
          unless business_subtypes.nil?
            business_subtypes.each do |x|
                business_subtype = BusinessSubtype.find_by(name: x)
                if business_subtype.nil?
                  puts "        *** business_subtype not found: "+x
                else
                  business.business_subtypes << business_subtype unless business.business_subtypes.include?(business_subtype)
                end
            end
          end
        end

        business.address1 = location
        business.phonenum = phone
        business.website = website

        unless service_type.nil?
          service_type = cleanup_service_type(service_type)
          business.service_type = ServiceType.find_by(name: service_type)
          if business.service_type.nil?
            puts "        *** service_type not found: "+service_type
          end
        end
        
        filename = business.name.gsub(' ',"-")
        image_filename = Dir.glob("/Volumes/GoogleDrive/My Drive/IT.Department User - Shared Docs/Advertising/LOGOS - Retailers Re-Sized/*"+filename+"*")
        image_filename = Dir.glob("/home/shoffmann/logos/*"+filename+"*") if image_filename.empty?
        if image_filename.empty?
          puts "Logo NOT found: "+filename
        else
          #puts "Logo uploaded: " + image_filename[0] unless image_filename.nil?
          business.logo = File.open(image_filename[0]) unless image_filename.nil?
        end
        
        business.save!
        
        puts "\n  Imported: "+name
        puts "            "+business.business_subtypes.collect{ |x| x.name }.join(",") unless business.business_subtypes.nil?
        puts "\n"
      end
    end
  end
        
  task :import_restaurant => [:environment] do
    puts "Importing restaurants from CSV file"

    file = "/Users/shoffmann/Downloads/Web_Restaurants.csv" if File.exist?("/Users/shoffmann/Downloads/Web_Restaurants.csv")
    file = "/home/shoffmann/Web_Restaurants.csv" if File.exist?("/home/shoffmann/Web_Restaurants.csv")
    business_type = "Restaurant"

    CSV.foreach(file) do |row|
      if !row[1].nil? && row[1] != "Restaurant" && row[1] != "Business"
        logo = row[0]
        name = row[1]
        business_subtypes = row[2]
        business_subtypes = cleanup_subtypes(row[2]).split(" ") unless business_subtypes.nil?
        location = row[3]
        phone = row[4]
        website = row[5]
        service_type = row[6]
        city = row[7]
        
        name = name.gsub("  "," ")
        
        business = Business.find_or_create_by(name: name, city: city)
        business.business_type = BusinessType.find_by(name: business_type)

        unless business_subtypes.nil?
          #puts "business_subtypes: "+business_subtypes.to_s
          unless business_subtypes.nil?
            business_subtypes.each do |x|
                business_subtype = BusinessSubtype.find_by(name: x)
                if business_subtype.nil?
                  puts "        *** business_subtype not found: "+x
                else
                  business.business_subtypes << business_subtype unless business.business_subtypes.include?(business_subtype)
                end
            end
          end
        end

        business.address1 = location
        business.phonenum = phone
        business.website = website

        unless service_type.nil?
          service_type = cleanup_service_type(service_type)
          business.service_type = ServiceType.find_by(name: service_type)
          if business.service_type.nil?
            puts "        *** service_type not found: "+service_type
          end
        end
        
        filename = business.name.gsub(' ',"-").gsub("'","")
        image_filename = Dir.glob("/Volumes/GoogleDrive/My Drive/IT.Department User - Shared Docs/Advertising/LOGOS - Restaurants Re-Sized/*"+filename+"*")
        image_filename = Dir.glob("/home/shoffmann/logos/*"+filename+"*") if image_filename.empty?
        if image_filename.empty?
          puts "Logo NOT found: "+filename
        else
          #puts "Logo uploaded: " + image_filename[0] unless image_filename.nil?
          business.logo = File.open(image_filename[0]) unless image_filename.nil?
        end
        business.save!
        
        puts "\n  Imported: "+name
        puts "            "+business.business_subtypes.collect{ |x| x.name }.join(",") unless business.business_subtypes.nil?
        puts "\n"
      end
    end
  end
  
  def cleanup_subtypes(subtype)
    subtype = subtype.gsub('"','')
    subtype = subtype.gsub(',','')
    subtype = subtype.gsub('&','')
    subtype = subtype.downcase.gsub('and','')
    subtype = subtype.downcase.gsub('more','')
    subtype = subtype.downcase.gsub('food','')
    subtype = subtype.downcase.gsub('restaurant','')
    subtype = subtype.downcase.gsub('pasta','Italian')
    subtype = subtype.downcase.gsub('sushi','Japanese')
    subtype = subtype.downcase.gsub('swich','Deli')
    subtype = subtype.downcase.gsub('swhiches','Deli')
    subtype = subtype.downcase.gsub('sandwicheses','Deli')
    subtype = subtype.downcase.gsub('delies','Deli')
    subtype = subtype.downcase.gsub('subs','Deli')
    subtype = subtype.downcase.gsub('salads','Deli')
    subtype = subtype.downcase.gsub('cafe','Deli')
    subtype = subtype.downcase.gsub('tacos','Mexican')
    subtype = subtype.downcase.gsub('taco','Mexican')
    subtype = subtype.downcase.gsub("mexican's",'Mexican')
    subtype = subtype.downcase.gsub('baked','Bakery')
    subtype = subtype.downcase.gsub('hamburger','American')
    subtype = subtype.downcase.gsub('burgers','American')
    subtype = subtype.downcase.gsub('bugers','American')
    subtype = subtype.downcase.gsub('chicken','American')
    subtype = subtype.downcase.gsub('americans','American')
    subtype = subtype.downcase.gsub('home','American')
    subtype = subtype.downcase.gsub('ice','Ice Cream / Yogurt')
    subtype = subtype.downcase.gsub('ice cream','Ice Cream / Yogurt')
    subtype = subtype.downcase.gsub('yogurt','Ice Cream / Yogurt')
    subtype = subtype.downcase.gsub('yogart','Ice Cream / Yogurt')
    subtype = subtype.downcase.gsub('gyros','Greek')
    subtype = subtype.downcase.gsub('hawaiin','Hawaiian')
    subtype = subtype.downcase.gsub('BBQ','Barbeque')
    subtype = subtype.downcase.gsub('coffee/cafe','Coffee')
  end

  def cleanup_service_type(service_type)
    service_type = service_type.downcase.gsub("pick up", "Pickup")
    service_type = service_type.downcase.gsub("pickup", "Pickup")
    service_type = service_type.downcase.gsub("pickup curbside", "Pickup")
    service_type = service_type.downcase.gsub("picl up", "Pickup")
    service_type = service_type.downcase.gsub("take out", "Pickup")
    service_type = service_type.downcase.gsub("delivery", "Delivery")
    service_type = service_type.downcase.gsub("deliver", "Delivery")
    service_type = service_type.downcase.gsub("deliveryy", "Delivery")
  end
end