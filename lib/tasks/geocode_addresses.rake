namespace :business do
  desc "GeoCode Business Addresses"

  task :geocode_addresses => [:environment] do
    puts "GeoCode Business Addresses"
    geo_count = 0
    @businesses = Business.all
    @businesses.each do |business|
      address = business_address_city_state_zip(business).upcase
      coords = Geocoder.coordinates(address)
      if coords.nil?
        address = business_address_city_state_zip_noaddress2(business).upcase
        coords = Geocoder.coordinates(address)
      end
      if coords.nil?
        puts "\nGeocoder coordinates nil: " + address
      else
        #puts "\nGeocoder coordinates: " + address + "\n" + coords[0].to_s + "," + coords[1].to_s
        business.lat = coords[0]
        business.lng = coords[1]
        business.save
        geo_count = geo_count + 1
      end
    end
    puts "Businesses with Lat/Long: "+geo_count.to_s
  end
  
  def business_address_city_state(business)
    address = ""
    address << business.address1 + ", " unless business.address1.nil?
    address << business.address2 + ", " unless business.address2.nil?
    address << business.city + " " unless business.city.nil?
    address << business.state + " " unless business.state.nil?
    return address
  end

  def business_address_city_state_zip(business)
    address = ""
    address << business.address1 + ", " unless business.address1.nil?
    address << business.address2 + ", " unless business.address2.nil?
    address << business.city + " " unless business.city.nil?
    address << business.state + " " unless business.state.nil?
    address << business.zipcode unless business.zipcode.nil?
    return address
  end

  def business_address_city_state_zip_noaddress2(business)
    address = ""
    address << business.address1 + ", " unless business.address1.nil?
    address << business.city + " " unless business.city.nil?
    address << business.state + " " unless business.state.nil?
    address << business.zipcode unless business.zipcode.nil?
    return address
  end
end
