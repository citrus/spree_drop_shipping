Spree Drop Shipping
===================

... is going to be pretty awesome.

---

### What is drop shipping?

"Drop shipping is a supply chain management technique in which the retailer does not keep goods in stock, but instead transfers customer orders and shipment details to either the manufacturer or a wholesaler, who then ships the goods directly to the customer." [[wikipedia](http://en.wikipedia.org/wiki/Drop_shipping)]

---

So the main goal with spree_drop_shipping is to link products to suppliers, and send batched orders to suppliers at the end of the day. 

In more detail, when an order is placed for a product that has a drop ship supplier, it will get added to its supplier's 'order queue'. The order queues will process daily sending orders to each supplier via email. Suppliers will be able to view their orders on the site and confirm that they've been received, billed and shipped. So far I've got the suppliers admin and product-linking in place, and I've started work on the order portion. Development is being done with [cucumber](https://github.com/cucumber/cucumber), [shoulda](https://github.com/thoughtbot/shoulda), [dummier](https://github.com/citrus/dummier) and [spork](https://github.com/timcharper/spork) should you decide to join...


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
    
And reboot your server:
  
    rails s
    
    
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
  
POW!


Demo
----

You can easily use the test/dummy app as a demo of spree_drop_shipping. Just `cd` to where you develop and run:

    git clone git://github.com/citrus/spree_drop_shipping.git
    cd spree_drop_shipping
    bundle install
    bundle exec dummier
    cd test/dummy  
    rake db:migrate db:seed db:sample
    rails s
    
    
You can also enable the `after_migrate` [dummier](https://github.com/citrus/dummier) hook by renaming `after_migrate.rb.sample` to `after_migrate.rb` in `lib/dummy_hooks` then re-run `bundle exec dummier`. In other words, just do this:

    cd spree_drop_shipping
    mv lib/dummy_hooks/after_migrate.rb.sample lib/dummy_hooks/after_migrate.rb
    bundle exec dummier
    cd test/dummy
    rails s
    
    
Now you can rinse and repeat with:

    # from test/dummy
    cd ../../
    bundle exec dummier
    cd test/dummy
    rails s
    
    
So fresh and so clean, clean...


Contributors
------------

So far it's just me; Spencer Steffen. 

If you'd like to help out feel free to fork and send me pull requests!


License
-------

Copyright (c) 2011 Spencer Steffen and Citrus, released under the New BSD License. All rights reserved.