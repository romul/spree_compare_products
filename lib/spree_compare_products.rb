require 'spree_core'
require 'spree_compare_products_hooks'
require 'spree_compare_products/comparable_container'

module SpreeCompareProducts
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../app/**/*_decorator*.rb')) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Taxonomy.class_eval do
        include SpreeCompareProducts::ComparableContainer
      end

      Taxon.class_eval do
        include SpreeCompareProducts::ComparableContainer

        def is_comparable?
          comparable? || taxonomy.comparable?
        end
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end

module SpreeBase
  module InstanceMethods
    protected

    def find_comparable_products
      session[:comparable_product_ids] ||= []
      product_ids = session[:comparable_product_ids]
      if product_ids.size > 0
        @comparable_products = Product.where(:id => product_ids)
      else
        @comparable_products = []
      end
    end
  end

  class << self

    def included_with_compare_products(receiver)
      included_without_compare_products(receiver)
      receiver.send :before_filter, 'find_comparable_products'
    end

    alias_method_chain :included, :compare_products
  end
end

