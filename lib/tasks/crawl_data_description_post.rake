desc "Fetch post with description"
task :fetch_title => :environment do
  require 'nokogiri'
  require 'open-uri'

  Post.where(title: nil).each do |post|
    url = "https://news.ycombinator.com/best"
    doc = Nokogiri::HTML(open(url))
    description = doc.at_css(".itemlist .athing .title:last-child").text
    post.update_attribute(:discription, description)
  end
end