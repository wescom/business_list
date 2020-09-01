module BusinessesHelper

  def business_address(business)
    address = ""
    address << business.address1 + ", " unless business.address1.nil?
    address << business.address2 + " " unless business.address2.nil?
    return address
  end

  def business_address_city(business)
    address = ""
    address << business.address1 + ", " unless business.address1.nil?
    address << business.address2 + " " unless business.address2.nil?
    address << business.city unless business.city.nil?
    return address
  end

  def business_address_city_state(business)
    address = ""
    address << business.address1 + ", " unless business.address1.nil?
    address << business.address2 + " " unless business.address2.nil?
    address << business.city + " " unless business.city.nil?
    address << business.state unless business.state.nil?
    return address
  end

  def business_address_city_state_zip(business)
    address = ""
    address << business.address1 + ", " unless business.address1.nil?
    address << business.address2 + " " unless business.address2.nil?
    address << business.city + " " unless business.city.nil?
    address << business.state + " " unless business.state.nil?
    address << business.zipcode unless business.zipcode.nil?
    return address
  end

  def shrink_url_field(url)
    unless url.nil?
      url = url.split('/')[2]
      url = url.gsub('www.','') unless url.nil?
      url = url.gsub('https://','') unless url.nil?
      url = url.gsub('http://','') unless url.nil?
    end
  end
end
