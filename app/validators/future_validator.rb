# app/validators/future_validator.rb
class FutureValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value.nil? || value > Time.now
        record.errors.add(attribute, "must be in the future")
      end
    end
end
  