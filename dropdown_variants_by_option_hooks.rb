class DropdownVariantsByOptionHooks < Spree::ThemeSupport::HookListener

  # Add javascripts
  insert_after :admin_inside_head, 'admin/shared/scripts'
  # Add checkbox to option type edit form
  insert_after :admin_option_type_edit_fields, 'admin/option_types/display_as_dropdown_form'
  # Override default add to cart form
  replace  :inside_product_cart_form, 'products/dropdown_variants_by_option_cart'

end
