require 'em-websocket'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "sms.db"
)

class Sms < ActiveRecord::Base
end


puts "listening..."

# binding.pry

EM.run do
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|



    ws.onopen do |handshake|
      puts "WebSocket connection open"

      last_text = Sms.last
      puts last_text.body
      ws.send last_text.body

      loop do
        if Sms.last.body != last_text.body
          last_text = Sms.last
          puts last_text.body
          ws.send last_text.body
        end
        puts "looping..."
        sleep 5
      end

      # Access properties on the EM::WebSocket::Handshake object, e.g.
      # path, query_string, origin, headers

      # Publish message to the client
      # ws.send "Hello Client, you connected to #{handshake.path}"
    end

    ws.onclose { puts "Connection closed" }

    # ws.onmessage do |msg|
    #   puts "Recieved message: #{msg}"
    #   ws.send sentences.sample
    # end

  end
end