class Fetcher

  def self.categories
    Wombat.crawl do
      base_url 'http://www.brainyquote.com/quotes/topics.html'
      categories 'xpath=//a[contains(@href, "/quotes/topics/topic")]', :list
    end
  end

  def self.quotes(category)
    category = category.gsub(' ', '').gsub('\'', '').downcase
    Wombat.crawl do
      base_url "http://www.brainyquote.com/quotes/topics/topic_#{category}.html"
      quote 'xpath=//div[@class="boxyPaddingBig"]', :iterator do
        message 'xpath=.//a[@title="view quote"]'
        author 'xpath=.//a[@title="view author"]'
      end
    end
  end

end

#call fetcher.categories --> give you categories from the site
#call fetcher.quotes --> give you quotes based on the category you pass in.