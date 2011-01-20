class SpreeCompareProductsHooks < Spree::ThemeSupport::HookListener
  
  insert_after :admin_inside_taxonomy_form, 'admin/taxonomies/comparable_field'
  
  replace :taxon_products, 'taxons/taxon_products'
  
  insert_after :products_list_item, 'shared/compare_product_field'
  
end
