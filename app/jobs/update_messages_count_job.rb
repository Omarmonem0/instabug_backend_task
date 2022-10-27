class UpdateMessagesCountJob < ApplicationJob
  queue_as :default
  KEY_LENGTH = 42
  UUID_LENGTH = 41
  def perform(*)
    ActiveRecord::Base.transaction do
      REDIS.keys('*').each do |key|
        if key[0] == 'C'
          # Extract application id and chat number from redis key CHAT-c9f7a23e-8b83-40b7-a6ba-d6d36e831648-1
          original_key = key.dup
          application_uuid = key.dup
          application_uuid.slice!(UUID_LENGTH, KEY_LENGTH)
          application_uuid.slice!(0, 5)
          key.slice!(0, KEY_LENGTH)
          Chat.where(number: key, application_id: application_uuid).update_all(messages_count: REDIS.get(original_key))
        end
      end
    end
  end
end