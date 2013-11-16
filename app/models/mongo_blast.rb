class MongoBlast
  #
  #include Mongoid::Document
  ##include Tenacity
  #
  #field :body, type: String
  #
  #shard_key :user_id
  #
  #t_belongs_to :user
  #
  #validates_presence_of :user, :body
  #validates_class_of :user, :is => 'User'
  #
  #def version
  #  self[:v] || 0
  #end
  #
  #def self.create_blast(params)
  #  begin
  #    blast = self.new(params)
  #    if blast.valid? && !blast.duplicate?
  #      blast.save!
  #      blast
  #    else
  #      []
  #    end
  #  rescue Mongo::ConnectionTimeoutError
  #    []
  #  rescue Mongo::ConnectionFailure
  #    []
  #  end
  #end
  #
  #def self.connection
  #  ActiveRecord::Base.connection
  #end
  #
  #def created_at
  #  id.generation_time.to_time
  #end
  #
  #def duplicate?
  #  #body = blast.body.gsub( /\A"/m, "" ).gsub( /"\Z/m, "" ).gsub(/\\/,"").gsub(/\"/,"")
  #  #blast.class.where(:user_id => user_id).where("created_at > ?", 15.minutes.ago).where(["body LIKE ?","%#{body}%"]).exists?
  #  false
  #end
  #
  #def wall_owner
  #  user
  #end
  #

end