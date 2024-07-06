class Pokemon < ApplicationRecord
  has_and_belongs_to_many :types
  has_and_belongs_to_many :moves

  has_one_attached :image

  validates :name, presence: true
  validates :height, numericality: { greater_than: 0 }
  validates :weight, numericality: { greater_than: 0 }

  scope :search, -> (query) { where('name LIKE ?', "%#{query}%")}
end
