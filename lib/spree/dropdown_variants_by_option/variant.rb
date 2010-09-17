module Spree::DropdownVariantsByOption::Variant

  def self.included(target)
    target.class_eval do
      # Try and find the variant from the supplied pair option_type <--> option value and product
      def self.find_by_option_values(product_id, opt_values)
        variants = Array.new
        product = Product.find(product_id)
        opt_values.each_pair do |opt_type, opt_value|
          variants << product.variants.select { |v| v.option_values.include? OptionValue.find_by_option_type_id_and_id(opt_type, opt_value) }
        end
        variants.flatten
      end
    end
  end

end