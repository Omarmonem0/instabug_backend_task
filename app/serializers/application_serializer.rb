class ApplicationSerializer < ActiveModel::Serializer
    attributes :name, :uuid, :chats_count
end
