class Blaster
  def initialize(blast, location=nil)
    @blast = blast
    @location = Location.find_by_id location
  end

  def save
    Rails.logger.error @blast.inspect
    @blast.location = @location || @blast.blaster.location
    @blast.save! && post_to_social_media
  end

  private

  def post_to_social_media
    author = @blast.blaster
    author.facebook_client.put_wall_post(@blast.body) if author.facebook_client
    author.twitter_client.update(@blast.body) if author.twitter_client
    author.linkedin_client.add_share(comment: @blast.body) if author.linkedin_client
    true
  end
end