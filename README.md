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

Clone this repo to where you develop, bundle up, then run `dummier' to get the show started:

    git clone git://github.com/citrus/spree_drop_shipping.git
    cd spree_drop_shipping
    bundle install
    bundle exec dummier

This will generate a fresh rails app in test/dummy, install spree & spree_drop_shipping, then migrate the test database. Sweet.


### Spork + Cucumber

To run the cucumber features, boot spork like this:

    bundle exec spork

Then, in another window, run:

    cucumber --drb


### Spork + Test::Unit
    
If you want to run shoulda tests, start spork with:

    bundle exec spork TestUnit
    #or 
    bundle exec spork t
        
In another window, run all tests:

    testdrb test/**/*_test.rb
    
Or just a specific test:

    testdrb test/unit/supplier_test.rb
  

### No Spork

If you don't want to spork, just use rake:

    # cucumber/capybara
    rake cucumber
    
    # test/unit
    rake test
    
    # both
    rake 
  


Demo
----

You can easily use the test/dummy app as a demo of spree_drop_shipping. Just clone the repo and run:

    git clone git://github.com/citrus/spree_drop_shipping.git
    cd spree_drop_shipping
    bundle install
    bundle exec dummier
    cd test/dummy  
    rake db:migrate db:seed db:sample
    rails s
    
    
You can also enable the `after_migrate` [dummier](https://github.com/citrus/dummier) hook by renaming `after_migrate.rb.sample` to `after_migrate.rb.sample` in `lib/dummy_hooks` then re-run `bundle exec dummier`:

    cd spree_drop_shipping
    mv lib/dummy_hooks/after_migrate.rb.sample lib/dummy_hooks/after_migrate.rb
    bundle exec dummier


Enjoy!

License
-------

Copyright (c) 2011 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.