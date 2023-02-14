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
      @wines = Wine.order(rating: :desc)
    end
  end

  def show
  end
end
# price_cents BETWEEN ? AND ?', params[:pxmin].to_i, params[:pxmax].to_i
# .where('price_cents <= ?', params[:pxmax].to_i * 100)
