class Image < ApplicationRecord
  enum type: { thumbnail: 0, standard_resolution: 1, low_resolution: 2}, _prefix: :type
end
