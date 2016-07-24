class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :repos, through: :memberships

  scope :without_token, -> { where.not(token: nil) }
end
