class Event < ApplicationRecord
  validates :name, presence: true
  validates :event_type, inclusion: { in: ["click", "view", "scroll", "play", "download", "refresh", "submit"]}
end