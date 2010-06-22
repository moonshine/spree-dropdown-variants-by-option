# Dropdown Variants By Option

This Spree extension will display variants by their option type values using either dropdowns
or radio buttons. When the product details page is displayed (products/show) it renders a
separate control for each option type assigned to the product. So for example if we had a product
with "Size" and "Color" as the option types, the show page will display all available sizes (e.g.
Small, Medium, Large) in one control and all available color's (e.g. Red, White, Black) in another.

The control used to display the option type values can either be a set of radio buttons or a
dropdown. The control used is configurable for each option type via the admin interface.

When the customer changes a selection the extension uses Ajax to communicate with the server to check
if a variant exists for the combination of values selected (e.g. Red, Large) it will also make sure
that the item is in stock if stock tracking is enabled. An 'Out of Stock' message will be displayed
as well as the 'Add to Cart' button disabled if the item is out of stock or it does not exist. If the
item exists and is in stock the show page will be updated to display the images assigned to the selected
variant.

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

## TODO list

Tests



