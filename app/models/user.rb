class User < ActiveRecord::Base
    has_many :lists, dependent: :destroy
    validates :name, uniqueness: true, presence: true
    validates :password, presence: true
end
