# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ApplicationRecord
  has_many :taggings,
  primary_key: :id,
  foreign_key: :topic_id,
  class_name: :Tagging

  has_many :urls,
    through: :taggings,
    source: :url

  def popular_links
    urls = self.urls.sort_by(&:num_clicks).reverse
    urls[0..4]
  end
end
