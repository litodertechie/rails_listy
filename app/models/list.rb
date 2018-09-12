class List < ApplicationRecord
  acts_as_votable
  include ::PublicActivity::Common
  belongs_to :user
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, allow_destroy: true
  after_create :track_list_create
  after_update :track_list_update

  def notification_to_s
    "your list"
  end
end


def track_list_create
  $tracker.track( user_id, 'Created List')
end

def track_list_update
  $tracker.track( user_id, 'Updated List')
end
