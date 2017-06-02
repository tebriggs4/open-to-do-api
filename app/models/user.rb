class User < ActiveRecord::Base
    has_many :lists
    validates :name, uniqueness: true, presence: true
    validates :password, presence: true
end
