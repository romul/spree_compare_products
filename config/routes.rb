Rails.application.routes.draw do
  match '/t/compare_products' => 'compare_products#show', :as => 'compare_products'
  match '/t/*taxon_path/compare/*product_ids' => 'compare_products#show'
end