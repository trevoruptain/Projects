# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

User.create(username: 'Trevor')
User.create(username: 'Ken')

Poll.destroy_all

Poll.create!(title: 'Schleebiness', author_id: 1)
Poll.create!(title: 'European History', author_id: 2)

Question.destroy_all

Question.create!(text: 'How many schlops are in a schpleeb?', poll_id: 1)
Question.create!(text: 'Who is Cesare Borgia?', poll_id: 2)

AnswerChoice.destroy_all

AnswerChoice.create!(text: 'One', question_id: 1)
AnswerChoice.create!(text: 'Four', question_id: 1)
AnswerChoice.create!(text: 'Sixteen', question_id: 1)
AnswerChoice.create!(text: 'Googolplex', question_id: 1)

AnswerChoice.create!(text: 'Dillon', question_id: 2)
AnswerChoice.create!(text: 'Jesus', question_id: 2)
AnswerChoice.create!(text: 'An asshole', question_id: 2)
AnswerChoice.create!(text: 'The pope', question_id: 2)

Response.destroy_all

Response.create!(answer_id: 4, user_id: 1)
Response.create!(answer_id: 5, user_id: 2)
