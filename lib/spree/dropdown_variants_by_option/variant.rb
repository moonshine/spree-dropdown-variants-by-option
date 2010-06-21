module Spree::DropdownVariantsByOption::Variant

  def self.included(target)
    target.class_eval do
      def self.find_by_option_values(product, option_values)
        join_clause = ''
        and_clause = ''
        option_values.each_with_index do |option_value, i|
          join_clause << " INNER JOIN option_values_variants ovv#{i} ON v.id = ovv#{i}.variant_id "
          and_clause << " AND ovv#{i}.option_value_id = #{option_value.last} "
        end
        Variant.find_by_sql("SELECT v.* FROM variants v #{join_clause}
          WHERE v.product_id = #{product}
          #{and_clause};").first
      end
    end
  end

end
