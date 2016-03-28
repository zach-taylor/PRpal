class Repo < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }


  def self.find_or_create_with(attributes)
    repo = find_by(full_github_name: attributes[:full_github_name]) ||
      find_by(github_id: attributes[:github_id]) ||
      Repo.new

    begin
      repo.update!(attributes)
    rescue ActiveRecord::RecordInvalid => error
      logger.error(error)
    end

    repo
  end
end
