module Spree::DropdownVariantsByOption::Order

  def self.included(target)
    target.class_eval do
      alias :spree_validate :validate unless method_defined?(:spree_validate)
      alias :validate :site_validate

      def dropdown_variants_by_option_add_variant(variant, quantity = 1)
        if variant.nil? || !variant.available?
          @variant_errors = I18n.t('out_of_stock')
        else
          self.add_variant(variant, quantity)
        end
      end
    end
  end

  def site_validate
    self.errors.add_to_base(@variant_errors) unless @variant_errors.nil?
  end

end
