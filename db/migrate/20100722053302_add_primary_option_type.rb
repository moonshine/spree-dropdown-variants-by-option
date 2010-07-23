class AddPrimaryOptionType < ActiveRecord::Migration
  def self.up
    add_column :option_types, :primary_option_type, :boolean, :default => false
  end

  def self.down
    remove_column :option_types, :primary_option_type
  end
end