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

Run `rake test_prep` to get the show started. This will generate a fresh rails app in test/dummy, install spree & spree_drop_shipping, then migrate the test database...

Sweet.




License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.