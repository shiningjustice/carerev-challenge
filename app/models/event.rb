class Event < ApplicationRecord
  validates :name, :event_type, presence: true
  # validates :name, presence: true
  # validates :event_type, inclusion: ["click", "view", "scroll", "play", "download", "refresh", "submit"]
end
