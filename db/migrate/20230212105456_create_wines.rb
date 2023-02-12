class CreateWines < ActiveRecord::Migration[7.0]
  def change
    create_table :wines do |t|
      t.string :name, index: true, null: false
      t.integer :sku_id
      t.integer :rating, null: false, index: true
      t.string :available
      t.text :wine_description
      t.string :wine_url
      t.string :wine_img
      t.string :wine_img_small
      t.string :domaine
      t.string :pays
      t.string :region, index: true
      t.string :couleur
      t.integer :millesime, index: true
      t.string :appellation, index: true
      t.string :culture
      t.string :cepages
      t.string :degre_dalcool
      t.string :temperature_de_service
      t.string :boire_ou_garder

      t.timestamps
    end
  end
end
