module S2Netbox::Helpers
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def blank?(value)
      value.nil? || value.length == 0
    end

  end

  def blank?(value)
    self.class.blank?(value)
  end
end