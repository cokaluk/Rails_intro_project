class Pokemon < ApplicationRecord
  has_and_belongs_to_many :types
  has_and_belongs_to_many :moves

  validates :name, presence: true
  validates :height, numericality: { greater_than: 0 }
  validates :weight, numericality: { greater_than: 0 }
end
