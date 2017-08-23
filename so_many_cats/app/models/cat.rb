require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = ['yellow', 'brown', 'black', 'orange', 'white', 'calico']

  validates :sex, inclusion: ['M', 'F']
  validates :color, inclusion: COLORS
  validates :birth_date, :color, :name, :sex, presence: true

  # has_many :rental_requests,
  #   class_name: :CatRentalRequest,
  #   dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end
end
