module S2Netbox::Helpers
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def blank?(value)
      value.nil? || value.length == 0
    end

    def build_params(params={})
      res = '<PARAMS>'

      params.each do |k, v|
        if v.is_a?(Hash)
          res << "<#{k.to_s}>"

          singular = v[:singular_node_name]

          v[:values].each do |inner_value|
            res << "<#{singular}>#{inner_value}</#{singular}>"
          end

          res << "</#{k.to_s}>"
        else
          res << "<#{k.to_s}>#{v}</#{k.to_s}>"
        end
      end

      res << '</PARAMS>'
    end

    def build_command(name, params=nil)
      "<COMMAND name='#{name}' num='1'>#{params ? build_params(params) : ''}</COMMAND>"
    end
  end

  def blank?(value)
    self.class.blank?(value)
  end

  def build_params(params={})
    self.class.build_params(params)
  end

  def build_command(name, params=nil)
    self.class.build_command(name, params)
  end
end