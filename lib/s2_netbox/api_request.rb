require 'facets/string/titlecase'

class S2Netbox::ApiRequest
  def self.send_request(command_name, attributes)
    S2Netbox.request(S2Netbox::BASIC_ENDPOINT, build_command(command_name, attributes))
  end

  def self.method_missing(method_name, *arguments, &block)
    return super unless supported_operations.include?(method_name.to_s)

    puts "Raw Args passed ot method_missing #{arguments}"

    mapped_args = map_attributes(arguments[0])

    puts "Mapped args: #{mapped_args}"

    send_request(command_for_method(method_name), mapped_args)
  end

  def self.respond_to_missing?(method_name, include_private = false)
    return true if supported_operations.include?(method_name.to_s)

    super
  end

  def self.supported_operations
    []
  end

  def self.command_map
    nil
  end

  def self.command_for_method(method_name)
    if command_map && command_map[method_name]
      return command_map[method_name]
    else
      return "#{name.split('::').last}#{method_name.to_s.gsub('_', ' ').titlecase.gsub(' ', '')}"
    end
  end
end
