require 'spree_core'
# require 'spree_auth'
require 'spree_sample' unless Rails.env.production?

module SpreeDropShipping

  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "static assets" do |app|
      app.middleware.insert_before ::Rack::Lock, ::ActionDispatch::Static, "#{config.root}/public"
    end

    def self.activate

      Spree::Order.class_eval do
        state_machine do
          after_transition :to => :complete, :do => :finalize_for_dropship!
        end
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

    end

    config.to_prepare &method(:activate).to_proc

  end

end
