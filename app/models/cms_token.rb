class CmsToken < ApplicationRecord
  belongs_to :material
  belongs_to :cms_session
  belongs_to :account

  validates :account, :material, :cms_session, presence: true

  before_create :generate_token
  before_create :assign_expire

  private

  def assign_expire
    self.expired_at = 1.minute.from_now
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64(50)
    generate_token if CmsToken.exists?(token: self.token)
  end
end
