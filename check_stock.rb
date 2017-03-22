require 'watir'
require 'twilio-ruby'

# Instantiates a Chromedriver browser
@browser = Watir::Browser.new :chrome

# Twilio credentials 
account_sid = "xxxxxxxxxx"
auth_token = "xxxxxxxxxx"

# Set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

# Visits the Google Store Pixel page
@browser.goto "https://store.google.com/config/pixel_phone"

# Checks if the phone is out of stock
if @browser.div(:class => "option-items").div(:class => "option-item").text.include? "Out of stock"
	puts "Out of stock"
else
	puts "In stock"

	# Sends SMS via Twilio of phone is in stock
	@client.messages.create(
  	from: '+xxxxxxxxxxx',
  	to: '+xxxxxxxxxxx',
  	body: 'Pixel is now in stock'
	)
end



