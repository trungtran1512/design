desc "Fetch post with title"
task :fetch_title => :environment do
  require 'nokogiri'
  require 'open-uri'

  Post.where(title: nil).each do |post|
    url = "https://news.ycombinator.com/best"
    doc = Nokogiri::HTML(open(url))
    title = doc.at_css(".itemlist .athing .title:last-child").text
    post.update_attribute(:title, title)
  end
end