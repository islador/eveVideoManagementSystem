class RemovePlpgsqlExtension < ActiveRecord::Migration
  def change
    disable_extension "plpgsql"
  end
end
