class List < ApplicationRecord
  acts_as_votable
  include ::PublicActivity::Common
  belongs_to :user
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |att| att['description'].blank?}
end

