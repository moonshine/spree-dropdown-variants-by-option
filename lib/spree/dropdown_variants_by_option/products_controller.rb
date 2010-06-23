module Spree::DropdownVariantsByOption::ProductsController

  def self.included(target)
    target.class_eval do
      def option_value_changed; site_option_value_changed; end
    end
  end

  private

  # Show all variants on the products/index page
  def site_option_value_changed
    @product = Product.find(params[:product_id])
    # Try and find the variant using the selected option values
    @selected_variant = Variant.find_by_option_values(@product.id, params[:option_values])
    @variants = Array.new
    @variants << @selected_variant if @selected_variant
    respond_to do |format|
      format.js { render :template => "products/site_option_values_changed.js.erb"}
    end
  end

end
