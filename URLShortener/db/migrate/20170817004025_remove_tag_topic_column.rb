class RemoveTagTopicColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column(:tag_topics, :url_id)
  end
end
