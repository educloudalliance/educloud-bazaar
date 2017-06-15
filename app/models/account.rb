class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable # :registerable, :recoverable, :rememberable
  enum kind: { lms: 0, cms: 1 }, _prefix: :kind

  validates :name, :kind, presence: true

  has_many :oauth_access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: 'resource_owner_id'
  has_many :materials
end
