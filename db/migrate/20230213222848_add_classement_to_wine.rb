class AddClassementToWine < ActiveRecord::Migration[7.0]
  def change
    add_column :wines, :classement, :string
  end
end
