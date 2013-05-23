module ApplicationHelper
  def class_if(klass, condition)
    klass if condition
  end
  
  def map_url(xml, url, changefreq = 'weekly', priority = '1')
    xml.url do
      xml.loc url
      xml.changefreq changefreq
      xml.priority priority
    end
  end
end
