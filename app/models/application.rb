class Application < ApplicationRecord
    validates :name, presence: true
    before_create :generate_uuid
    after_create :chat_count_cache
    has_many :chats, foreign_key: :application_id
    self.primary_key = :uuid

    protected

    def generate_uuid
        self.uuid = SecureRandom.uuid
    end

    def  chat_count_cache
        REDIS.set('APP'.concat('-', self.uuid), 0)
    end
end
