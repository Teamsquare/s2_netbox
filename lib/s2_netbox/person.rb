class S2Netbox::Person
  include S2Netbox::Helpers

  def self.add(attributes={}, access_levels=[], user_defined_fields=[])
    send_request('AddPerson', build_attributes(attributes, access_levels, user_defined_fields))
  end

  def self.modify(person_id, attributes={}, access_levels=[], user_defined_fields=[])
    person_attributes = build_attributes(attributes, access_levels, user_defined_fields)
    person_attributes['PERSONID'] = person_id

    send_request('ModifyPerson', person_attributes)
  end

  def self.build_attributes(attributes, access_levels, user_defined_fields)
    hash = map_attributes(attributes)
    hash = build_user_defined_fields(hash, user_defined_fields)
    hash = build_access_level(hash, access_levels)

    hash
  end

  def self.build_access_level(hash, access_levels)
    unless access_levels.empty?
      hash['ACCESSLEVELS'] = {:singular_node_name => 'ACCESSLEVEL', :values => access_levels}
    end

    hash
  end

  def self.build_user_defined_fields(hash, user_defined_fields)
    Array.wrap(user_defined_fields).each_with_index do |udf, index|
      hash["UDF#{index+1}"] = udf
    end

    hash
  end

  protected

  def self.send_request(command_name, attributes)
    S2Netbox.request(S2Netbox::BASIC_ENDPOINT, build_command(command_name, attributes))
  end
end