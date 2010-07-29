module Spree::DropdownVariantsByOption::ProductsHelper
  def self.included(base)
    base.class_eval do
      # Find all option values for the specified option type and product
      def instock_option_values(variant, option_type)
        option_values = Array.new
        option_type.option_values.each do |option_value|
          # Find all variants that have this option value and is available
          #
          # If not primary option make sure to only find those variants that
          # have the current option value but also the primary option value.
          # So if the variant passed to us has a primary option (color) == 'Blue'
          # find all variants where the color option type has the value 'Blue' as
          # well as the current option value being processed, e.g. 'Large'
          unless option_type.primary_option_type?
            # Retrieve primary option type value for the variant
            primary_option_type = variant.product.option_types.primary.first
            primary_option_type_value = variant.option_values.find_by_option_type_id(primary_option_type.id)
            variants = variant.product.variants.has_option(primary_option_type_value.id).has_option(option_value.id)
          else
            variants = variant.product.variants.has_option(option_value.id)
          end

          # Check if the variants found are in stock, if so add the option value
          # as one of the values to display as a possible selection
          # ** Problem when doing this as "Out of Stock" displayed for option
          # so when "Add to Cart" it will not pass in this option value and it
          # will find an instock product for the remaining option types **
          #
          #instock = variants.detect { |v| v.available? }
          instock = variants.first
          option_values << option_value if instock
        end
        
        option_values
      end
    end
  end
end