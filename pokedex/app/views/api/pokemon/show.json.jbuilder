json.pokemon do
  json.extract! @poke, :id, :name, :attack, :defense , :image_url, :moves, :poke_type
end

json.items @poke.items.each do |item|
  json.extract! item, :id, :name, :pokemon_id, :price, :happiness, :image_url
end
