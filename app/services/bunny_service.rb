require 'bunny'

class BunnyService
  def self.produce
    connection = Bunny.new
    connection.start
    channel = connection.create_channel
    queue = channel.queue('hello')
    channel.default_exchange.publish('Hello World!', routing_key: queue.name)
    puts " [x] Sent 'Hello World!'"
  ensure
    connection.close
  end

  def self.consume
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    queue = channel.queue('hello')

    begin
      puts ' [*] Waiting for messages. To exit press CTRL+C'
      # block: true is only used to keep the main thread
      # alive. Please avoid using it in real world applications.
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        puts " [x] Received #{body}"
      end
    ensure
      connection.close
    end
  end
end
