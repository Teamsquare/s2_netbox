[![CircleCI](https://circleci.com/gh/Teamsquare/s2_netbox/tree/develop.svg?style=svg)](https://circleci.com/gh/teamsquare/s2_netbox/tree/develop)
[![Code Climate](https://codeclimate.com/github/Teamsquare/s2_netbox/badges/gpa.svg)](https://codeclimate.com/github/teamsquare/s2_netbox)
[![Test Coverage](https://codeclimate.com/github/Teamsquare/s2_netbox/badges/coverage.svg)](https://codeclimate.com/github/teamsquare/s2_netbox/coverage)
[![Issue Count](https://codeclimate.com/github/Teamsquare/s2_netbox/badges/issue_count.svg)](https://codeclimate.com/github/teamsquare/s2_netbox)

This gem provides Ruby bindings to the [S2 NetBox](http://s2sys.com/products/access-control-systems/netbox/) API for [S2 Security Systems](http://s2sys.com/) products.
# Currently Supported API methods
This Gem has been written pretty specifically for the needs of Teamsquare's internal management systems.
Although every method **should** work if you follow the right conventions, only the specific ones we're using have been built out and tested.

The specific methods we're using have been documented under the Usage section.  See the section "Other Commands" for details on how to invoke any arbitrary command in addition to the list of "supported" commands below.

# Installation
Add this line to your application's Gemfile:

    gem 's2_netbox'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install s2_netbox

# Configuration
A call to `S2Netbox.configure` must be made before API requests can be made.  This sets up the controller's base URL as well as the username and password used when logging in.

```ruby
S2Netbox.configure do |config|
    config.controller_url = 'https://controller-host'	
    config.username = 'api'
    config.password  = '[W2tnwoUdE+/97o8nmi#P77t'
end
```    
If you're using the S2Netbox gem in a Rails app, this could be placed in an initializer.
# Usage
All requests are bundled up into the required XML parcel with the required `COMMAND` and `PARAMS`.
Once sent to the configured S2 controller, the response is wrapped up in an instance of `S2Netbox::Response` which includes the following accessors:

* `code`
* `success`
* `details`
* `error_message`
* `raw_request`
* `raw_response`
* `session_id`

`code` returns the raw code response which is typcially either `SUCCESS` or `FAIL`, but sometimes has weird other alternatives, such as `DUPLICATE` or `NOT FOUND` just to keep things interesting.

`success` is a boolean indicating if the `code` was `SUCCESS`.  Any other value for `code` results in `success` being `false`.

`details` is a hash of the returned details. For example, when getting a Person object, this will contain the person's attributes, such as `FIRSTNAME` and `LASTNAME` as well as a hash of `ACCESSLEVELS`.  The details hash is keyed off the raw names of the XML attributes in the response (uppercase names, as a string, not symbole) so access them like:

    @result.details['FIRSTNAME']
    
not

    @result.details[:first_name]

`error_message` is populated with the error mesage returned from the system assuming `code` is not `SUCCESS`.

The `raw_request` and `raw_response` store the contents of the HTTP Post request and response respectively, so you can troubleshoot exactly what XML was sent and received by the systems.

`session_id` contains the value of the `session_id` attribute if it exists on the root `<NETBOX>` element in the `raw_response`.  This is only populated in response to the `Login` command.  Use this when parsing the result of a `Login` attempt and store the `session_id` for future requests.

# Authentication
The gem supports authentication by username and password only. Although you can configure it to use the `sha_password` method of authentication, at pesent the MAC signature is not generated or included with any request.

If your S2 system requires authentication via the `sha_password` and MAC signing, feel free to open a pull request :) Our systems are partitioned and don't use this form of authentication, but we'd love to accept a pull request to add this fucntionaltiy for other users.
## Login
Login is used to establish a session and obtain a `session_id` which is used in subsequent requests:

      @result = S2Netbox::Commands::Authentication.login

To get an instance of `S2Netbox::Response` which (assuming log in is succesful) will include the `session_id` which can be used in subsequent requests:

    @result.session_id

## Logout
All sessions must be logged out. According to the S2 documentation:

> WARNING: Failure to match every call to ‘Login’ with a call to ‘Logout’ will result in the accumulation of session files, consuming potentially large amounts of disk space.

To log out, issue the `logout` command:

    @result = S2Netbox::Commands::Authentication.logout('session_id_from_login')

# Version
The `Version` module allows you to query the current API version.  This is really just an easy way to validate you're successfully connected to the S2 Controller and have a valid session.
## GetVersion
    @result = S2Netbox::Commands::ApiVersion.get_version('session_id_from_login')
The result object will contain the version (assuming you've successfully logged in):

    :001 > puts @result.details['APIVERSION']
    4.1

# Person
The `Person` module allows you to add and modfy Pereson records.
## AddPerson
The `add_person` method accepts 3 arguments:

1. Hash of person attributes
1. List of access levels 
1. List of User Defined Fields
1. (Optional) session_id

```ruby
@result = S2Netbox::Commands::Person.add({
    :person_id => '8a806ed6-0246-49d0-b7a7-ab6402da01e3',
    :first_name => 'John',
    :last_name => 'Appleseed',
    :exp_date => nil,
    :act_date => '10/10/2016'
    }, %w(AccessLevel1 AccessLevel2), 'UDF1'
)
```
Both access levels and user defined fields can be specified either as a single string or as an array of strings.
## ModifyPerson
The `modify_person` method allows you to modify an existing person, and is similar to the `add_person` method, but has an additional argument:

1. Person ID
1. Hash of person attributes
1. List of access levels 
1. List of User Defined Fields
1. (Optional) session_id

```ruby
@result = S2Netbox::Commands::Person.modify('8a806ed6-0246-49d0-b7a7-ab6402da01e3', {
    :first_name => 'John',
    :last_name => 'Appleseed',
    :exp_date => nil,
    :act_date => '10/10/2016'
}, %w(AccessLevel1 AccessLevel2), 'UDF1')
```
Access levels and user defined fields are replaced with those values specified in this call, and aren't additive to existing access levels or user defined fields.
# Credentials


# Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git add -p ./path/to/files; git commit -m 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request

# License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

