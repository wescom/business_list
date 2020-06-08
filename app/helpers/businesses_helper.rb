module BusinessesHelper

  def shrink_url_field(url)
    unless url.nil?
      url = url.split('/')[2]
      url = url.gsub('www.','') unless url.nil?
      url = url.gsub('https://','') unless url.nil?
      url = url.gsub('http://','') unless url.nil?
    end
  end
end
