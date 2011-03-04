class CompareProductsController < Spree::BaseController
  
  before_filter :find_taxon, :only => [:show, :add]
  #before_filter :verify_comparable_taxon, :only => :show
  
  helper :products, :taxons
  
  def show
    @properties = @products.map(&:properties).flatten.uniq # We return the list of properties here so we can use them latter.
  end
  
  def add
    product = Product.find_by_permalink(params[:id])
    if product && (product.taxons.map(&:id).include?(@taxon.try(:id)) || @products.size < 1)
      session[:comparable_product_ids] << product.id
      session[:comparable_product_ids].uniq!
      flash[:notice] = I18n.t(:added_to_comparison, :scope => :compare_products)
    else
      session[:comparable_product_ids].delete(product.id) 
      flash[:error] = I18n.t(:invalid_taxon, :scope => :compare_products)
    end
    respond_to do |format|
      format.html { redirect_back_or_default(products_path) }
      format.js { render :layout => false }  
    end
  end
  
  def remove
    session[:comparable_product_ids] ||= []
    product = Product.find_by_permalink(params[:id])
    if product
      session[:comparable_product_ids].delete(product.id)
      flash[:notice] = I18n.t(:removed_from_comparison, :product => product.name, :scope => :compare_products)
    end
    respond_to do |format|
      format.html { redirect_back_or_default(products_path) }
      format.js { render :layout => false }  
    end
  end
  
  def destroy
    session[:comparable_product_ids] = []
    flash[:notice] = I18n.t(:comparison_cleared, :scope => :compare_products)
    respond_to do |format|
      format.html { redirect_back_or_default(products_path) }
      format.js { render :layout => false }  
    end
  end
  
  private
  
  def find_taxon
    @products = find_products
    if @products.size > 1
      @taxon = @products.inject(@products[0].taxons){|t, p| t & p.taxons }.select{|t| t.is_comparable? }.first

      if @taxon.nil?
        flash[:error] = I18n.t('compare_products.invalid_taxon')
      end
    elsif @products.size == 1
      @taxon = @products[0].taxons.select{|t| t.is_comparable? }.first
    end
  end
  
  
  def find_products
    session[:comparable_product_ids] ||= []
    product_ids = session[:comparable_product_ids]
    if product_ids.length >= 4
      flash[:notice] = I18n.t('compare_products.limit_is_4')
      product_ids = product_ids[0...3]
    elsif product_ids.length < 2
      flash[:error] = I18n.t('compare_products.insufficient_data')
    end
    Product.find(:all, :conditions => { :id => product_ids}, :include => { :product_properties => :property }, :limit => 4)
  end
  
end
