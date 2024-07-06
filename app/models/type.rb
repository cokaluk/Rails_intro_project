class Type < ApplicationRecord
  has_and_belongs_to_many :pokemons

  validates :name, presence: true

  scope :search, -> (query) { where('name LIKE ?', "%#{query}%")}
end
