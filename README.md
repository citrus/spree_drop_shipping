Spree Drop Shipping
===================

... is nearing completion!

---

### What is drop shipping?

"Drop shipping is a supply chain management technique in which the retailer does not keep goods in stock, but instead transfers customer orders and shipment details to either the manufacturer or a wholesaler, who then ships the goods directly to the customer." [[wikipedia](http://en.wikipedia.org/wiki/Drop_shipping)]

---

So the main goal with spree_drop_shipping is to link products to suppliers and forward orders to appropriate suppliers. 

In more detail, once an order is placed for a product that drop ships a drop ship order is created for the product's supplier. This drop ship order is sent to the supplier via Email. The supplier then follows a link to the order within the email where they are prompted to confirm the order. 

After the supplier has confirmed an order and is ready to ship, they can log into the site and update the drop ship order with a shipping method, confirmation number and tracking number. Once they 'process & finalize' the order, the customer is notified with the shipment details.


Todo
----

- Finish/Style Email templates
- Drop ship order styles
- Finish I18n implementation
- Spree 0.70+ compatibility
- Better documentation


Installation
------------

Here's how to install spree_drop_shipping into your existing spree site:


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
    
You should be up and running now!


### Sample Data

If you'd like to generate sample data, use the included rake tasks

    rake db:sample                    # Loads sample data into the store
    rake db:sample:suppliers          # Create sample suppliers and randomly link to products
    rake db:sample:drop_ship_orders   # Create sample drop ship orders


Testing
-------

Clone this repo to where you develop, bundle up, then run `dummier' to get the show started:

    git clone git://github.com/citrus/spree_drop_shipping.git
    cd spree_drop_shipping
    bundle install
    bundle exec dummier

This will generate a fresh rails app in test/dummy, install spree & spree_drop_shipping, then migrate the test database. Sweet.

Note: Currently you must hit enter `n` to reject overwriting conflicts, and simply hit `enter` when prompted for email and password.

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
    

Contributors
------------

So far it's just me; Spencer Steffen. 

If you'd like to help out feel free to fork and send me pull requests!


License
-------

Copyright (c) 2011 Spencer Steffen and Citrus, released under the New BSD License. All rights reserved.
