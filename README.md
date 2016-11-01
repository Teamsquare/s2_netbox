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
## Rails Application

## Non-rails application
When using 
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
Call:
      @result = S2Netbox::Authentication.login
To get an instance of `S2Netbox::Response`
## Logout
# Version
## GetVersion
# Person
## AddPerson
## ModifyPerson
# Other commands


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

