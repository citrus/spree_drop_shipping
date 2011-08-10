# install spree and migrate db
rake "spree_core:install spree_auth:install spree_sample:install"
run "rails g spree_drop_shipping:install"
