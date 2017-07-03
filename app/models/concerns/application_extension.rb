module ApplicationExtension
  extend ActiveSupport::Concern

  included do
    has_many :materials
  end
end
