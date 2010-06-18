class AddPositionToOptionTypes < ActiveRecord::Migration
  def self.up
    add_column :option_types, :display_as_dropdown, :boolean, :default => false
    add_column :option_types, :redirect_on_select, :boolean, :default => false
  end

  def self.down
    remove_column :option_types, :display_as_dropdown
    remove_column :option_types, :redirect_on_select
  end
end