module Spree::DropdownVariantsByOption::Variant

  def self.included(target)
    target.class_eval do
      # Try and find the variant from the supplied option values and product
      def self.find_by_option_values(product, option_values)
        join_clause = ''
        and_clause = ''
        option_values.each_with_index do |option_value, i|
          join_clause << " INNER JOIN option_values_variants ovv#{i} ON variants.id = ovv#{i}.variant_id "
          and_clause << " AND ovv#{i}.option_value_id = #{option_value.last} "
        end
        Variant.find_by_sql("SELECT variants.* FROM variants #{join_clause}
          WHERE variants.deleted_at is null AND
          variants.product_id = #{product}
          #{and_clause};")
      end
    end
  end

end
