class User < ActiveRecord::Base
    has_many :lists
    validates :name, uniqueness: true
end
