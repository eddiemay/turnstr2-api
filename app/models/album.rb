class Album < ApplicationRecord
	belongs_to :user
	has_many :photos

	scope :current, -> { where(month: Date.today.month, year: Date.today.year ).limit(1)}
end
