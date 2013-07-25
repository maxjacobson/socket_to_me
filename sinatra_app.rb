Bundler.require

set :database, "sqlite3:///sms.db"

class Sms < ActiveRecord::Base
end
 
get '/' do
    'Hello World! Currently running version ' + Twilio::VERSION + \
        ' of the twilio-ruby library.'
end

get '/sms-quickstart' do
  puts params.inspect

  Sms.create(body: params["Body"], from_num: params["From"])

  # File.open("texts.txt", "rw") do |f|
  #   f.write params["Body"]
  # end
  # raise params.inspect
  # twiml = Twilio::TwiML::Response.new do |r|
  #   r.Sms "I don't know haha lol"
  # end
  # twiml.text
end



# what we get back from twilio in params hash
# {"AccountSid"=>"AC1f75327324bc8d3ed5c8bee48750c93c",
#  "Body"=>"Can you see me? Let me know!!!",
#  "ToZip"=>"10011",
#  "FromState"=>"OH",
#  "ToCity"=>"NEW YORK",
#  "SmsSid"=>"SM1d90bdeef0600c723e6a019d93740a24",
#  "ToState"=>"NY",
#  "To"=>"+16468635311",
#  "ToCountry"=>"US",
#  "FromCountry"=>"US",
#  "SmsMessageSid"=>"SM1d90bdeef0600c723e6a019d93740a24",
#  "ApiVersion"=>"2010-04-01",
#  "FromCity"=>"AKRON",
#  "SmsStatus"=>"received",
#  "From"=>"+13307036872",
#  "FromZip"=>"44302"}
