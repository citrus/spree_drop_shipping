Spree Drop Shipping
===================

... is going to be pretty awesome.


Installation
------------

Here's how you'll install spree_drop_shipping into your existing spree site:


Add the following to your Gemfile:

    gem 'spree_drop_shipping', :git => 'git://github.com/citrus/spree_drop_shipping.git'

Make your bundle happy:

    bundle install
    
Now run the generator:

    rails g spree_drop_shipping:install
    
Then migrate your database:

    rake db:migrate
    
    
You should be up and running now! - except that this gem doesn't do anything yet hahahaha!



Testing
-------

Clone this repo to where you develop, then run `rake test_prep` to get the show started. This will generate a fresh rails app in test/dummy, install spree & spree_drop_shipping, then migrate the test database...

Sweet. Now we can spork and open a new window to run the tests in...

To run the cucumber features, boot spork like this:

    bundle exec spork

Then, in another window, run:

    bundle exec cucumber --drb
    
If you want to run shoulda tests, start spork with:

    bundle exec spork TestUnit
    
In another window, run all tests:

    bundle exec testdrb test/**/*_test.rb
    
Or just a specific test:

    bundle exec testdrb test/unit/supplier_test.rb
  


License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.