require 'facets/string/titlecase'

class S2Netbox::ApiRequest
  include S2Netbox::Helpers

  def self.provides_command(*command_names)
    define_singleton_method(:supported_operations) do
      Array.wrap(command_names)
    end
  end

  def self.send_request(command_name, attributes, session_id=nil)
    S2Netbox.request(S2Netbox::BASIC_ENDPOINT, build_command(command_name, map_attributes(attributes)), session_id)
  end

  def self.method_missing(method_name, *arguments, &block)
    return super unless supported_operations.include?(method_name)

    attributes = arguments[0]
    session_id = arguments[1]

    if arguments.length == 1 && !arguments[0].is_a?(Hash)
      # there is only a single argument, and it isn't a hash - assume it is session_id
      attributes = nil
      session_id = arguments[0]
    end

    send_request(command_for_method(method_name), attributes, session_id)
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
      return "#{method_name.to_s.tr('_', ' ').titlecase.delete(' ')}#{name.split('::').last}"
    end
  end

  def self.build_params(params={})
    res = '<PARAMS>'

    params.each do |k, v|
      if v.is_a?(Hash)
        res << "<#{k}>"

        singular = v[:singular_node_name]

        v[:values].each do |inner_value|
          res << "<#{singular}>#{inner_value}</#{singular}>"
        end

        res << "</#{k}>"
      else
        res << "<#{k}>#{v}</#{k}>"
      end
    end

    res << '</PARAMS>'
  end

  def self.build_command(name, params=nil)
    "<COMMAND name='#{name}' num='1'>#{params ? build_params(params) : ''}</COMMAND>"
  end

  def self.map_attributes(attributes)
    return unless attributes

    attributes.map { |k, v| [k.to_s.delete('_').upcase, blank?(v) ? '' : v] }.to_h
  end
end
