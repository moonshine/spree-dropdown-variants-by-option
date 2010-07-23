module Spree::DropdownVariantsByOption::OrdersController
  JS_ESCAPE_MAP = { '\\' => '\\\\', '</' => '<\/', "\r\n" => '\n', "\n" => '\n', "\r" => '\n', '"' => '\\"', "'" => "\\'" }

  def self.included(target)
    target.class_eval do
      create.before << :add_variants_from_option_values
      create.wants.js
      create.failure.wants.js { render :js => "alert('#{format_js_error}')" }
    end
  end

  private

  def add_variants_from_option_values
    # Combine primary and non-primary option values to locate the correct variant
    option_values = params[:option_values] ? params[:option_values_primary].merge(params[:option_values]) : params[:option_values_primary]
    if option_values and params[:product_id]
      @variant = Variant.find_by_option_values(params[:product_id], option_values).first
      quantity = params[:quantity].to_i
      @object.dropdown_variants_by_option_add_variant(@variant, quantity) if quantity > 0
    end
  end

  def format_js_error
    message = "The following error(s) have occurred when trying to add the item to the cart: "
    @order.errors.each_full {|m| message += "#{m} "}
    message.gsub(/(\\|<\/|\r\n|[\n\r"'])/) { JS_ESCAPE_MAP[$1] }
    message
  end

end
