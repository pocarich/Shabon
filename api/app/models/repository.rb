class Repository < ApplicationRecord
    has_many :chapters, dependent: :destroy
    belongs_to :user
end
