module Spree::DropdownVariantsByOption::OptionType

  def self.included(target)
    target.class_eval do
      named_scope :primary, {:conditions => ["primary_option_type = ?", true]}
      named_scope :not_primary, {:conditions => ["primary_option_type = ?", false]}
    end
  end

end
