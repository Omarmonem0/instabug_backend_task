class UpdateChatsCountJob < ApplicationJob
  queue_as :default

  def perform(*)
    tokens = []
    ActiveRecord::Base.transaction do
      REDIS.keys('*').each do |key|
        if key[0] == 'A'
          key.slice!(0, 4)
          tokens.push(uuid: key, chats_count: REDIS.get('APP'.concat('-',key)))
        end
      end
      if tokens.length
        grouped_tokens = tokens.index_by { |application| application[:uuid]  }
        Application.update(grouped_tokens.keys, grouped_tokens.values)
      end
    end
  end
end