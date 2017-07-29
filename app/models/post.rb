class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged


  belongs_to :author
  scope :most_recent, -> {order(id: :desc)}
  scope :published, -> {where("published = true")}

  def should_generate_new_friendly_id?
    title_changed?
  end

  def display_day_published
    "Published on #{created_at.strftime('%-b %-d %-Y')}"
  end
end