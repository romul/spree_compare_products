class SpreeCompareProductsHooks < Spree::ThemeSupport::HookListener
  
  insert_after :admin_inside_taxonomy_form, 'admin/taxonomies/comparable_field'
  
  replace :taxon_products, 'taxons/taxon_products'
  
  insert_after :products_list_item, 'shared/compare_product_field'
  
  insert_after :sidebar do 
    %(
    <div class="sidebar-item" id="comparable_products_wrapper">
      <%= render 'shared/comparable_products' %>
    </div>
    )
  end
  
  insert_after :inside_head do
    "<%= javascript_include_tag 'product_comparison' %>"
  end
  
end
