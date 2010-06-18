module Spree::DropdownVariantsByOption::Admin::ProductsController

  def self.included(target)
    target.class_eval do
      def reorder_product_option_types; site_reorder_product_option_types; end
    end
  end

  private

  # Reorder the option types for a product
  def site_reorder_product_option_types
    product = Product.find(params[:id])
    product.product_option_types.each do |product_option_type|
      product_option_type.update_attribute(:position, params['option_type'].index(product_option_type.option_type_id.to_s) + 1)
    end
    render :nothing => true
  end

end
