# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :taggings,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Tagging

  has_many :tag_topics,
    through: :taggings,
    source: :topic

  def self.random_code
    code = SecureRandom.urlsafe_base64[0...16]
    until !ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64[0...16]
    end
    code
  end

  def self.create!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.new(long_url: long_url, short_url: short_url, user_id: user.id)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    # self.visits.reject { |visit| Time.now - visit.updated_at.time > 600 }.count
    visits = self.visits.select(:user_id).distinct
    # time_window = Time.now - 600
    visits.where({updated_at: (Time.now - 600)..Time.now}).count
  end
end
