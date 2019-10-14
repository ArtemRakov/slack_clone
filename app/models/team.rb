class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true, format: { with: /\A\S*\z/ }
  validates :description, presence: true

  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations
  has_many :channels, dependent: :destroy

  belongs_to :owner, class_name: "User"

  def to_s
    name
  end

  def find_channel(id)
    channels.friendly.find(id)
  end
end
