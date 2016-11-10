require 'facets/string/titlecase'

class S2Netbox::ApiRequest
  include S2Netbox::Helpers

  def self.provides_command(*command_names)
    define_singleton_method(:supported_operations) do
      Array.wrap(command_names)
    end
  end

  def self.send_request(command_name, attributes, session_id=nil)
    S2Netbox.request(S2Netbox::BASIC_ENDPOINT, build_command(command_name, attributes), session_id)
  end

  def self.method_missing(method_name, *arguments, &block)
    return super unless supported_operations.include?(method_name)

    send_request(command_for_method(method_name), map_attributes(arguments[0]), arguments[1])
  end

  def self.respond_to_missing?(method_name, include_private = false)
    return true if supported_operations.include?(method_name.to_s)

    super
  end

  def self.command_map
    nil
  end

  def self.supported_operations
    []
  end

  def self.command_for_method(method_name)
    if command_map && command_map[method_name]
      return command_map[method_name]
    else
      return "#{method_name.to_s.gsub('_', ' ').titlecase.gsub(' ', '')}#{name.split('::').last}"
    end
  end

  def self.build_params(params={})
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

  def self.build_command(name, params=nil)
    "<COMMAND name='#{name}' num='1'>#{params ? build_params(params) : ''}</COMMAND>"
  end

  def self.map_attributes(attributes)
    return unless attributes

    attributes.reject { |_,v| blank?(v) }.map { |k, v| [k.to_s.gsub('_', '').upcase, v] }.to_h
  end
end
