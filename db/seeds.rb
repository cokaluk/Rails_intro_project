require 'open-uri'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


##Commenting out as it has already been created while im testing seeding for pokemons/types
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Pokemon.delete_all()
Type.delete_all()
Move.delete_all()

# query pokemon api for first 1000 pokemon
def fetch_pokemon_data(limit = 20)

  pokemon_data = []

  (1..limit).each do |id|
    info = PokeApi.get(pokemon: id)
    pokemon_data << {
      name: info.name,
      height: info.height,
      weight: info.weight,
      image: info.sprites.front_default,
      types: info.types.map { |type| type.type.name },
      moves: info.moves.map { |move| move.move.name }
    }
  end

  pokemon_data
end

def seed_pokemon
  pokemon_data = fetch_pokemon_data

  pokemon_data.each do |data|
    retries = 3
    begin
      ActiveRecord::Base.transaction do
        pokemon = Pokemon.create(name: data[:name], height: data[:height], weight: data[:weight])

        data[:types].each do |type_name|
          type = Type.find_or_create_by(name: type_name)
          pokemon.types << type
        end

        data[:moves].each do |move_name|
          move = Move.find_or_create_by(name: move_name)
          pokemon.moves << move
        end

        if data[:image].present?
          file = URI.open(data[:image])
          pokemon.image.attach(io: file, filename: data[:name], content_type: file.content_type)
        end
      end

    rescue => e
      retries -= 1
      if retries > 0
        sleep(1)
        retry
      end
    end
  end
end


seed_pokemon
