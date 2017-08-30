class Post < AbstractResource
  attributes :url, :source, :embed, :author, :image, :title, :original_timestamp,
             :next_page, :description, :created, :user_id, :visible, :comments, :social_feed_id,
             :social_post_id, :social_id, :phash, :height, :width, :original_image, :timestamp,
             :post_id, :user_rights, :nsfw_score, :language, :likes_count, :shares_count,
             :replies_count, :cta, :highlight, :pinned, :recur_frequency, :recur_offset, :geo,
             :tags, :popup_function, :tweet_urls, :retweeted_by, :custom_field, :offset,
             :ref_timestamp, :unique_offset, :relative_offset

  def initialize(args = {})
    super(args)
  end
end
