require 'krakow'
require 'redis'
require "synchro_consumer/version"
require "synchro_consumer/storage_processor"
require "synchro_consumer/messages_receiver"

#Process.daemon(true, true)

#pid_file = File.dirname(__FILE__) + "/#{__FILE__}.pid"
#File.open(pid_file, 'w') { |f| f.write Process.pid }

module SynchroConsumer
  class Consumer
    def initialize
      storage_processor = SynchroConsumer::StorageProcessor.new
      SynchroConsumer::MessagesReceiver.new(storage_processor, topic: 'current_pharmacy')
    end
  end
end
