class S2Netbox::Configuration
  attr_accessor :controller_url
  attr_accessor :sha_password
  attr_accessor :username
  attr_accessor :password

  def initialize
    @controller_url = nil
    @sha_password = nil
    @username = nil
    @password = nil
  end

  def sign_with_mac?
    !blank?(sha_password)
  end

  def validate!
    validate_controller_url!

    if !blank?(sha_password) && (!blank?(username) || !blank?(password))
      raise S2Netbox::Errors::ConfigurationError.new 'Must specify either sha_password or username and password (not both)'
    end

    if blank?(username) && blank?(password)
      validate_sha_password!
    else
      validate_username_and_password!
    end
  end

  private

  def validate_controller_url!
    raise_error_unless(controller_url, 'Must specify sha_password')
  end

  def validate_sha_password!
    raise_error_unless(sha_password, 'Must specify sha_password')
  end

  def validate_username_and_password!
    if blank?(username) || blank?(password)
      raise S2Netbox::Errors::ConfigurationError.new 'Must specify either sha_password or username and password'
    end
  end

  def raise_error_unless(value, message=nil)
    if blank? value
      raise S2Netbox::Errors::ConfigurationError.new message
    end
  end

  def blank?(value)
    value.nil? || value.length == 0
  end
end