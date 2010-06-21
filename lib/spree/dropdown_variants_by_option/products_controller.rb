module Spree::DropdownVariantsByOption::ProductsController

  def self.included(target)
    target.class_eval do
      def option_value_changed; site_option_value_changed; end
    end
  end

  private

  # Show all variants on the products/index page
  def site_option_value_changed
    render :update do |page|
      product = Product.find_by_permalink(params[:id])
      variant = Variant.find_by_option_values(product.id, params[:option_values])
      i = 1
      #page.replace_html 'option_values_dropdown', :text => 'hello'
    end
  end

end
