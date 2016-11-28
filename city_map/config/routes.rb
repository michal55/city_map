Rails.application.routes.draw do

  root 'map#index'

  get 'map/within/:type/:within/:coordinates/:color' => 'map#within'

  get 'map/streets_within/:type/:within/:coordinates/:color/:streets_within/:number_of' => 'map#streets_within'

  get 'map/find/:name/:color' => 'map#find'

end
