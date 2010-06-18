# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class DropdownVariantsByOptionExtension < Spree::Extension
  version "1.0"
  description "Display variants as dropdowns on product add to form"
  url "http://yourwebsite.com/dropdown_variants_by_option"

  # Please use dropdown_variants_by_option/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    # Override spree admin products controller to allow option types ordering
    Admin::ProductsController.send(:include, Spree::DropdownVariantsByOption::Admin::ProductsController)

    # Order product option_types association by position
    Product.send(:include, Spree::DropdownVariantsByOption::Product)

    # Add helper to construct options for variant dropdown
    ProductsHelper.send(:include, Spree::DropdownVariantsByOption::ProductsHelper)

  end
end
