module Spree::DropdownVariantsByOption::Product

  def self.included(target)
    target.class_eval do
      # Allow option types to be ordered, override default association
      has_many :option_types, :order => :position, :through => :product_option_types
    end
  end

end
