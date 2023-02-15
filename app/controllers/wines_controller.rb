class WinesController < ApplicationController
  def index
    if params[:query].present?
      sql_query = <<~SQL
        name @@ :query
        OR domaine @@ :query
        OR appellation @@ :query
        OR region @@ :query
        OR couleur @@ :query
      SQL

      @wines =  Wine
                .where(sql_query, query: "%#{params[:query]}%")
                .where('price_cents BETWEEN ? and ?', params[:pxmin].to_i * 100, params[:pxmax].to_i * 100)
                .order(rating: :desc)
    else
      @wines = ''
    end
  end

  def show
    @wine = Wine.find(params[:id])
    @caracteristique = ["domaine", "pays", "region", "couleur", "millesime", "appellation", "culture", "cepages", "degre_dalcool", "temperature_de_service", "boire_ou_garder", "classement" ]
    @key_val_to_display = []
    @transform_obj_to_hash = JSON.parse(@wine.to_json)
    @caracteristique.each do |k|
      @key_val_to_display << [k.to_s, @transform_obj_to_hash[k]] if JSON.parse(@wine.to_json).key?(k)
    end
  end
end
