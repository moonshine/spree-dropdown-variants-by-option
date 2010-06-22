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
      @product = Product.find(params[:product_id])
      # Try and find the variant using the selected option values
      @selected_variant = Variant.find_by_option_values(@product.id, params[:option_values])
      @variants = Array.new
      @variants << @selected_variant if @selected_variant
      # Refresh the thumbnails to show those for the selected variant
      page.replace_html 'thumbnails', :partial => 'thumbnails', :locals => {:product => @product}
      # Display out of stock message if no variant found
      if !@selected_variant || !@selected_variant.available?
        page.replace_html 'variant-images', :text => "#{t('out_of_stock')}"
        # Disable add to cart
        page << "$('#add_to_cart_submit').attr('disabled', true).unbind()"
        # Change text on button
        page << "$('#add_to_cart_submit').html('#{t('out_of_stock')}')"
      else
        # Enable add to cart
        page << "$('#add_to_cart_submit').removeAttr('disabled')"
        # Display text on button
        page << "$('#add_to_cart_submit').html('#{t('add_to_cart')}')"
      end
      # Reassign the image handlers after we replace the html above
      page << 'add_image_handlers();'
    end
  end

end
