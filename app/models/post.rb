class Post < ActiveRecord::Base

  validates_presence_of :title, :content, :user
  belongs_to :user


  scope :published, ->{where(published: true)}

end
