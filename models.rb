class User < ActiveRecord::Base
  validates :first_name, :last_name, :birthday, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, length: {minimum: 5, maximum: 10}

  has_many :posts, dependent: :destroy
  end

class Post < ActiveRecord::Base
  validates :content, length: {minimum: 1}

  belongs_to :user
end