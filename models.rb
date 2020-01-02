class User < ActiveRecord::Base
    validates :first_name, :last_name, :birthday, :email, :password, :active,  presence: true
    validates :email, uniqueness: true
  end