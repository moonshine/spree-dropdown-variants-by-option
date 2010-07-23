# Dropdown Variants By Option

This Spree extension will display variants by their option type values using either dropdowns
or radio buttons. When the product details page is displayed (products/show) it renders a
separate control for each option type assigned to the product. So for example if we had a product
with "Size" and "Color" as the option types, the show page will display all available sizes (e.g.
Small, Medium, Large) in one control and all available color's (e.g. Red, White, Black) in another.

The control used to display the option type values can either be a set of radio buttons or a
dropdown. The control used is configurable for each option type via the admin interface.

It is a requirement that you nominate one of the option types to be the "primary" option type. The
primary option type is used to control the values displayed in the non-primary option types. For example
if we nominated the "Color" option type to be the primary type and we selected "Blue", only option values
for variants that contain the "Blue" option value will be displayed. So if "Blue" had variants S, M, L then
these will be the only available option values displayed for size.

If the user changes the primary option type an Ajax call is made to refresh the values displayed for the
other option types. So if "Red" was selected and it had M, L, XL as it's option values then the dropdown for size
will be changed to only display the option values for red, i.e. M, L, XL.

The extension also adds an Ajax "Add to cart", when the user adds an item to the cart the system will
make an Ajax call to add the item to the cart. Once the item has been added the cart details in the header
is updated and an alert box displayed informing the user that the item was added.

Inspired and some code borrowed from the extension developed by Tim Case,
see http://github.com/timcase/spree-dropdown-variants

## Usage

### Installation

Install the extension and run the migration.

### Specify control type

By default the option values are rendered using a set of radio buttons. To use a dropdown instead
a new checkbox has been added to the option type maintenance form in the admin section called
"Display as a drop down selection" which when selected will cause the option values to be rendered
using a dropdown.

### Nominate the primary option type

You are required to nominate one of the product's option types as the "primary" option type (e.g. color).
This option type is used to determine the option values to display for all the non-primary option types
such as size for example. When the value of the primary option type is changed an Ajax call is made to
update the values of all other option types.

### Copy spree partial

Due to clashes with other extensions I've had to modify the option_types edit form partial by adding
in additional hooks. I've included the updated partial and it can be found in the root directory
of this extension and is called _form.html.erb. You will need to copy it to this directory in your
spree installation:

vendor/extensions/theme_default/app/views/admin/option_types/_form.html.erb

## TODO list

Tests



