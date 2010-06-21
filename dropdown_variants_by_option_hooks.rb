class DropdownVariantsByOptionHooks < Spree::ThemeSupport::HookListener

  # Add admin javascripts
  insert_after :admin_inside_head do
    "<%= javascript_include_tag 'jquery-ui-1.7.3.custom.min' %>"
  end
  insert_after :inside_head do
    "<%= javascript_include_tag 'dropdown_variants_by_option_product' %>"
  end
  # Add checkbox to option type edit form
  insert_after :admin_option_type_edit_fields, 'admin/option_types/display_as_dropdown_form'
  # Override default add to cart form
  replace  :inside_product_cart_form, 'products/dropdown_variants_by_option_cart'

end
