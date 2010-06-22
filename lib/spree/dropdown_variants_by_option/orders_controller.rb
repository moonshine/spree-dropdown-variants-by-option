module Spree::DropdownVariantsByOption::OrdersController

  def self.included(target)
    target.class_eval do
      create.before << :add_variants_from_option_values
    end
  end

  private

  def add_variants_from_option_values
    if params[:option_values] and params[:product_id]
      variant = Variant.find_by_option_values(params[:product_id], params[:option_values])
      quantity = params[:quantity].to_i
      @object.dropdown_variants_by_option_add_variant(variant, quantity) if quantity > 0
    end
  end

end
