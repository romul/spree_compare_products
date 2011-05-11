// ######################
// # PRODUCT COMPARISON #
// ######################

// @param params <Object> : {
//   target <String> : the target object
// }

var ProductComparison = function(params) {
  // ################
  // # DEPENDENCIES #
  // ################
  
  if (typeof jQuery == 'undefined') {
    throw new Error('InquiryAsk requires \'jQuery\'.');
  }
  
  // #############
  // # PARAMETER #
  // #############
  
  // if (params.target == undefined) {
  //   throw new Error('ProductComparison constructor requires a \'target\'.');
  // }
  
  // ######################
  // # PRIVATE ATTRIBUTES #
  // ######################
  
  var self = this;
  
  // ######################
  // # PRIVILEGED METHODS #
  // ######################
  
  /* 
   * @privileged
   * 
   * init
   * 
   * Initialize product comparison
   */
  this.init = function() {
    _init();
  }
  
  // ###################
  // # PRIVATE METHODS #
  // ###################
  
  /* 
   * @private
   * 
   * _init
   * 
   * Initialize product comparison
   */
  function _init() {
    _setForm();
    $('input.compare:checkbox').click(_setForm);
    $('form[action*="/t/compare_products"]').submit(_onFormSubmit);
  }
  
  /* 
   * @private
   * 
   * _setForm
   */
  function _setForm() {
    var checkedProducts = $('input.compare:checkbox:checked').length; // Get number of checked products
    
    _disableIf('form[action*="/t/compare_products"] :submit', (checkedProducts < 2)); // Disable form if less than 2 products are checked
  }
  
  /* 
   * @private
   * 
   * _onFormSubmit
   */
  function _onFormSubmit() {
    var taxon_permalink = $('input#taxon_permalink:hidden').val();
    var product_ids = $.map($('input.compare:checkbox:checked'), function(n) { return n.value; }).join('/');
    
    window.location = '/t/' + taxon_permalink + '/compare/' + product_ids;
    
    return false;
  };
  
  /* 
   * @private
   * 
   * _disableIf
   */
  function _disableIf(query, value) {
    $(query).attr('disabled', value);
  }
  
  _init(); // Initialize product comparison
}
