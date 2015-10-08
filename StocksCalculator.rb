require 'HTTParty'
require 'Nokogiri'
require 'colorize'

class StocksCalculator
	def initialize(stock_abbrev,stock_name)
	@stock_name = stock_name
	@stock_abbrev = stock_abbrev
	@stockpage = HTTParty.get("http://finance.yahoo.com/q?s=#{@stock_abbrev}")
	@dom = Nokogiri::HTML(@stockpage.body)

	end
	def get_stock
		@stockprice = @dom.xpath("//span[@id='yfs_l84_#{@stock_abbrev}']").first
		@max = @stockprice.content
		puts "#{@stock_name}: $#{@max}"
		refresh_price
	end
	def refresh_price
		sleep(5)
		@dom = Nokogiri::HTML(@stockpage.body)
		@stockprice = @dom.xpath("//span[@id='yfs_l84_#{@stock_abbrev}']").first
		difference = @stockprice.content.to_f - @max.to_f
		if @stockprice.content > @max
			puts "#{@stock_name}:" + " $#{@stockprice.content} ⇧ $#{difference}".colorize(:green)
			@max = @stockprice.content
		elsif @max < @stockprice.content
			puts "#{@stock_name}:"+" $#{@stockprice.content} ⇩ $#{difference}".colorize(:red)
		else
			puts "#{@stock_name}:"+" $#{@stockprice.content} ↺ $#{difference}".colorize(:white)
		end
		refresh_price
	end
end
def run
puts "Enter stock name"
stock_name = gets.chomp
puts "Enter stock abbreviation"
stock_abbrev = gets.chomp
new_stock = StocksCalculator.new(stock_abbrev,stock_name)
new_stock.get_stock

end
run
