module ActiveModel

  module Validations
    class IsAValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        return unless record.send(attribute)
        class_message = 'aeiou'.include?(options[:is].to_s[0].downcase) ? "an #{options[:is]}" : "a #{options[:is]}"
        unless record.send(attribute).is_a?(options[:is].constantize)
          record.errors.add(attribute, :must_be, :class_message => class_message)
        end
      end
    end

    module HelperMethods
      def validates_class_of(*attr_names)
        validates_with IsAValidator, _merge_attributes(attr_names)
      end
    end
  end
end
