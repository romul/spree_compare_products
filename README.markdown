SPREE COMPARE PRODUCTS
======================

DESCRIPTION:
------------

Provides product comparison with other products within the same taxon.

This is a fork of [spree-compare-products](https://github.com/calas/spree-compare-products) by Jorge Calás.

REQUIREMENTS:
-------------

* {Spree}(https://github.com/railsdog/spree) (Version >= 0.50.99)

FEATURES:
---------

* Allows the admin user to select which taxonomies are comparable.
* Provides a bookmark-able URL.
* Only allows products comparison in comparable taxonomies.
* Only compares products in the same exact taxon.
* Compares up to 4 products.
* Redirects to the product's taxon page if only one product is provided.
* If javascript is available:
  * Disabling submit button when less than 2 products are selected.
  * Submit to the correct URL (to avoid server-side redirection).

TODOS:
------

* Add tests
* Bring back all features provided by the original extension 
* Don't rely on javascript