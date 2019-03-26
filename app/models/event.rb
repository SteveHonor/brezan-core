class Event < ApplicationRecord
  belongs_to :client
  has_many :albums, dependent: :delete_all
end
