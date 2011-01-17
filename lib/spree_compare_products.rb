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