# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ApplicationRecord
  belongs_to :answer_choice,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :answer_id

  belongs_to :respondent,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

    has_one :question,
      through: :answer_choice,
      source: :question


  def sibling_responses
    question.responses
  end
end
