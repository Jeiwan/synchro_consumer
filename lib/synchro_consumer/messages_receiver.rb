module SynchroConsumer
  class MessagesReceiver
    def initialize(storage_processor, host: 'localhost', port: 4150, topic: '', channel: 'synchro')
      return ArgumentError unless storage_processor
      @host, @port, @topic, @channel = host, port, topic, channel
      @storage_processor = storage_processor
      puts ">>>>>> MessagesReceiver initialized"
      connect
    end

    private

    def connect
      @consumer = Krakow::Consumer.new(
        host: @host,
        port: @port,
        topic: @topic,
        channel: @channel
      )
      puts ">>>>>> MessagesReceiver connected"
      process_messages
    end

    def process_messages
      puts ">>>>>> MessagesReceiver.process_messages"
      while true do
        # TODO: придумать транзакцию
        message = @consumer.queue.pop
        puts ">>>>>> MessagesReceiver #{message.content}"
        @storage_processor.queue_message(message.content)
        @consumer.confirm(message.message_id)
      end
    ensure
      @consumer.terminate
    end
  end
end
