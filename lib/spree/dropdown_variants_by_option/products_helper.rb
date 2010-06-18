module Spree::DropdownVariantsByOption::ProductsHelper
  def self.included(base)
    base.class_eval do
      def instock_option_values(product, option_type)
        # Find all option value for the specified option type as we want
        # all option values in the specified order
        option_values = Array.new
        option_type.option_values.each do |option_value|
          # Find all variants that have this option value and is available
          instock = product.variants.all(:include => :option_values, :conditions => "option_values.id = #{option_value.id}").detect {
            |v| v.available? }
          option_values << option_value if instock
        end
        option_values
      end
    end
  end

end