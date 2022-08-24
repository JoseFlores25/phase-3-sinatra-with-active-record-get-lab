class ApplicationController < Sinatra::Base

  # Add this line to set the Content-Type header for all responses
  set :default_content_type, 'application/json'

  # add routes
  get '/' do
    {message: "Hello Bakery"}.to_json
  end

  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json( only: [:name], include: {
      baked_goods: { only: [:name, :price] }
    })
end

get '/baked_goods/by_price' do
  baked_goods = BakedGood.all.order(price: :desc)
  baked_goods.to_json
end

  get '/baked_goods/most_expensive' do
    baked_good = BakedGood.by_price.first
    baked_good.to_json
  end

end
