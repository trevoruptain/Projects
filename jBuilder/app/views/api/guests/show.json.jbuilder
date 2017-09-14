json.partial!('guest', guest: @guest)

json.gifts @guest.gifts.each do |gift|
  json.extract! gift, :title, :description
end
