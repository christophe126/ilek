class AddIndexOnColorToWine < ActiveRecord::Migration[7.0]
  def change
    add_index(:wines, :couleur)
  end
end
