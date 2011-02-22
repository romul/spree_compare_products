Rails.application.routes.draw do
  match '/compare_products' => 'compare_products#show', :as => 'compare_products'
  match '/compare_products/add/:id' => 'compare_products#add', :as => 'add_to_comparison'
  match '/compare_products/remove/:id' => 'compare_products#remove', :as => 'remove_from_comparison'
  match '/compare_products/destroy' => 'compare_products#destroy', :as => 'destroy_comparison'
  match '/t/*taxon_path/compare/*product_ids' => 'compare_products#show'
end
