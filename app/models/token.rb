class Token < ApplicationRecord
  validates :client_id, presence: true, uniqueness: true
  validates :secret_key, presence: true, uniqueness: true
end
