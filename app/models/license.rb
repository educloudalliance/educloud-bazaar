class License < ApplicationRecord
  belongs_to :product

  validates :product, presence: true
  validates :city_id, presence: true, if: :require_city_id?

  private

  def require_city_id?
    school_id?
  end
end
