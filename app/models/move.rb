class Move < ApplicationRecord
  has_and_belongs_to_many :pokemons

  validates :name, presence: true
end
