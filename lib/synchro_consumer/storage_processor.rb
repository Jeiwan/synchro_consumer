module SynchroConsumer
  class StorageProcessor
    def initialize(host: 'localhost', port: 6379)
      @host, @port = host, port
      puts ">>>>>> StorageProcessor initialized"
      connect
    end

    def queue_message(message)
      puts ">>>>>> StorageProcessor.queue_message"
      @redis.lpush 'Synchro:messages', message
    end

    private

    def connect
      @redis = Redis.new(host: @host, port: @port)
      puts ">>>>>> StorageProcessor connected"
    end
  end
end
