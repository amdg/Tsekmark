module Tsekmark
  module Mongoid
    module HasManyMongo

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        include ActiveSupport::Inflector

        def has_many_mongo(association_id, opts={})
          define_method(association_id) do
            model_class = opts[:class_name].constantize || association_id.to_s.classify.constantize
            this = opts[:delegate] ? self.send("#{opts[:delegate]}") : self
            if opts[:as]
              as = opts[:as]
              model_class.where("#{as}_id" => this.id, "#{as}_type" => this.class.base_class.sti_name)
            else
              as = ActiveSupport::Inflector.underscore(this.class.base_class)
              model_class.where("#{as}_id" => this.id)
            end

          end

          if opts[:dependent] == :delete_all
            before_destroy do
              send(association_id).delete_all
            end
          end
        end
      end
    end
  end
end