namespace :quote do
  desc "fetch"
  task :fetch => :environment do
    puts 'Fetching Categories!'
    categories = Fetcher.categories['categories']
    categories = categories.map { |c| Category.where(:name => c).first_or_create }

    categories.each do |c|
      puts "Fetching quotes for #{c.name}"
      quotes = Fetcher.quotes(c.name)['quote']
      quotes.each { |q| Quote.where(:message => q['message'], :author => q['author'], :category_id => c.id).first_or_create }
    end
  end
end