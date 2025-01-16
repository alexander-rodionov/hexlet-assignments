# frozen_string_literal: true

require 'date'

# BEGIN
module Model
  CONVERTER = {
    integer: ->(v) { v.to_i },
    string: ->(v) { v.to_s },
    datetime: ->(v) { DateTime.parse v },
    boolean: ->(v) { v and true }
  }.freeze

  def initialize(*vals)
    vals = vals.any? ? vals[0] : {}
    defaults = self.class.instance_variable_get('@defaults')
    defaults.each_key { |k| send("#{k}=", vals[k] || defaults[k]) if respond_to? "#{k}=" }
  end

  def self.included(cls)
    cls.extend(InnerModule)
    cls.instance_variable_set '@defaults', {}
  end

  def attributes
    self.class.instance_variable_get('@defaults').each_key.each_with_object({}) { |k, a| a[k] = send(k.to_s) }
  end

  module InnerModule
    def attribute(name, type: :string, default: nil)
      define_method("#{name}=") { |v| instance_variable_set "@#{name}", v }
      define_method(name) do
        val = instance_variable_get("@#{name}")
        val&.then { CONVERTER[type].call(val) }
      end
      instance_variable_get('@defaults')[name] = default
    end
  end
end
# END
