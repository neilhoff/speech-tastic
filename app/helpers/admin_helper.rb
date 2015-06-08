module AdminHelper

  def posts_for(tag)
    Post.tagged_with(tag.name)
  end

end
