class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_taggable

  validates_presence_of :title, :content, :user
  belongs_to :user


  scope :published, ->{where(published: true)}

end
