module Spree::DropdownVariantsByOption::ProductsController

  def self.included(target)
    target.class_eval do
      show.before { check_for_primary_option_type }
      def option_value_changed; site_option_value_changed; end
     end
  end

  private

  # Show all variants on the products/index page
  def site_option_value_changed
    @product = Product.find(params[:product_id])
    # We want to find the first in stock variant that has the selected 
    # primary option type value, e.g. Blue
    @selected_variant = Variant.find_by_option_values(@product.id, params[:option_values_primary]).detect { |v| v.available? }
    @variants = Array.new
    @variants << @selected_variant if @selected_variant
    respond_to do |format|
      format.js { render :template => "products/site_option_values_changed.js.erb"}
    end
  end

  # Make sure the product has a primary option type if it has variants
  def check_for_primary_option_type
    return if @product.variants.size <= 0
    if @product.option_types.primary.size <= 0
      raise "No primary option type defined for product sku: #{@product.sku} name: #{@product.name}.
        A primary option type is required for the dropdown variants to be displayed correctly."
    end
  end

end
