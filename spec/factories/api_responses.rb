FactoryGirl.define do
  factory :api_response, :class => S2Netbox::ApiResponse do
    raw_request "APIcommand=<NETBOX-API><COMMAND name='GetAPIVersion' num='1'></COMMAND></NETBOX-API>"
    raw_response "<NETBOX><RESPONSE command='GetAPIVersion' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><APIVERSION>4.1</APIVERSION></DETAILS></RESPONSE></NETBOX>"

    trait :unsuccessful do
      raw_response "<NETBOX><RESPONSE command='GetAPIVersion' num=\"1\"><CODE>FAIL</CODE><DETAILS><ERRMSG>Something went wrong</ERRMSG></DETAILS></RESPONSE></NETBOX>"
    end

    trait :nested_details do
      raw_response "<NETBOX><RESPONSE command='SearchPersonData' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><VEHICLES><VEHICLE><VEHICLECOLOR>Vehicle 1 Color</VEHICLECOLOR><VEHICLEMAKE>Vehicle 1 Make</VEHICLEMAKE></VEHICLE><VEHICLE><VEHICLECOLOR>Vehicle 2 Color</VEHICLECOLOR><VEHICLEMAKE>Vehicle 2 Make</VEHICLEMAKE></VEHICLE></VEHICLES><ACCESSLEVELS><ACCESSLEVEL>MEL2_Member</ACCESSLEVEL><ACCESSLEVEL>MEL2_208</ACCESSLEVEL></ACCESSLEVELS></DETAILS></RESPONSE></NETBOX>"
    end

    trait :successful_login_response do
      raw_response "<NETBOX sessionid='255385874'><RESPONSE command='Login' num=\"1\"><CODE>SUCCESS</CODE></RESPONSE></NETBOX>"
    end

    initialize_with do
      new(raw_request, raw_response)
    end
  end
end