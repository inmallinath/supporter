class Agent < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true

  scope :search, lambda {|query|
                    where (["name || email || department || message ILIKE ?", "%#{query}%"])}
end
