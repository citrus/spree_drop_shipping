# install spree and migrate db
rake "spree_core:install spree_sample:install"
run "rails g spree_drop_shipping:install"
