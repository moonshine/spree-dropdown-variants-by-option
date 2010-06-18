class DropdownVariantsByOptionHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_inside_head, 'admin/shared/scripts'
  insert_after :admin_option_type_edit_fields, 'admin/option_types/display_as_dropdown_form'

end
