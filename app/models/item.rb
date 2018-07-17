class Item < ApplicationRecord
  belongs_to :list, optional: true
end
