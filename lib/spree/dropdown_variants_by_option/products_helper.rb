module Spree::DropdownVariantsByOption::ProductsHelper
  def self.included(base)
    base.class_eval do
      # Find all option values for the specified option type and product
      def instock_option_values(product, option_type)
        option_values = Array.new
        option_type.option_values.each do |option_value|
          # Find all variants that have this option value and is available
          instock = product.variants.all(:include => :option_values,
            :conditions => "option_values.id = #{option_value.id}").detect {
            |v| v.available? }
          option_values << option_value if instock
        end
        option_values
      end

      def generate_variant_option_values(product)        
        output_option_type(product) do |option_type|
          concat('<li>'  + option_type.presentation + '<br/>')
          option_values = instock_option_values(product, option_type)
          if option_values.empty?
            concat(t('out_of_stock'))
          else
            if option_type.display_as_dropdown
              concat(select_tag "option_types[#{option_type.id}]",
                options_from_collection_for_select(option_values, :id, :presentation))
            else
              instock_option_values(@product, option_type).each_with_index do |option_value, index|
                concat('<li>')
                concat(radio_button_tag "option_types[#{option_type.id}]", option_value.id, (index < 1))
                concat('<span class="variant-description">')
                concat(option_value.presentation)
                concat('</span>')
                concat('</li>')
              end
            end
          end
          concat('</li>')
        end

      end
      
      private
      
      def output_option_type(product, &block)
        concat('<ul>')
        product.option_types.each do |option_type|
          yield option_type
        end
        concat('</ul>')
      end
    end
  end

end