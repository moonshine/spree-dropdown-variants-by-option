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
      @product = Product.find_by_permalink(params[:id])
      @selected_variant = Variant.find_by_option_values(@product.id, params[:option_values])
      @variants = Array.new
      @variants << @selected_variant if @selected_variant
      page.replace_html 'thumbnails', :partial => 'thumbnails', :locals => {:product => @product}
      unless @selected_variant
        page.replace_html 'variant-images', :text => "#{t('out_of_stock')}"
      end
    end
  end

end
