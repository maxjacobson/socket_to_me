require 'em-websocket'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "sms.db"
)

class Sms < ActiveRecord::Base
  def pretty_print
    "#{body} from #{from_num[0..4]}-xxx-xxxx"
  end
end


puts "listening..."

# binding.pry

EM.run do
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8081) do |ws|


    ws.onopen do |handshake|
      puts "WebSocket connection open"

      # things to inspect
      # with theory: no need for sinatra app necessarily...
      # puts handshake.query_string
      # puts handshake.query
      # puts handshake.query.inspect
      # puts handshake.parser.query_string.inspect
      # ws.send "Hello Client, you connected to #{handshake.path}"
      Sms.all.each do |sms|
        ws.send sms.pretty_print
      end
    end

    ws.onclose { puts "Connection closed" }

    ws.onmessage do |msg|
      puts "Recieved message: #{msg}"
      last_text = Sms.last
      ws.send last_text.pretty_print
    end

  end
end