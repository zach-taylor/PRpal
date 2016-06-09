class Repo < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }


  def self.find_by_github(attributes)
    find_by(full_github_name: attributes[:full_github_name]) ||
      find_by(github_id: attributes[:github_id])
  end
end
