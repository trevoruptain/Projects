# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TagTopic.create(topic: "llamas")
TagTopic.create(topic: "tacos")
TagTopic.create(topic: "ice cream")

Tagging.create(url_id: 2, topic_id: 1)
Tagging.create(url_id: 3, topic_id: 2)
Tagging.create(url_id: 4, topic_id: 3)
Tagging.create(url_id: 2, topic_id: 3)
