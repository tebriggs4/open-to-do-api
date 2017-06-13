class User < ActiveRecord::Base
    has_many :lists, dependent: :destroy
    has_many :items, through: :lists
    validates :name, uniqueness: true, presence: true
    validates :password, presence: true
end
