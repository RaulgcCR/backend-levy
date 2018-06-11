Rails.application.routes.draw do
  resources :comments
  get 'main/index'

  resources :scores
  devise_for :admins
  resources :users
  resources :stores
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'

  get '/users/add/:nombre/:primerapellido/:segundoapellido/:correo/:password/:foto' => 'users#newUser'
  get '/users/modify/:id/:nombre/:primerapellido/:segundoapellido/:correo/:password/:foto/:token' => 'users#modifyUser'
  get '/users/login/:correo/:password' => 'users#newLog'
  get '/users/login/:token' => 'users#newLogToken'

  get '/articles/add/:nombre/:precio/:descripcion/:proveedor/:imagen/:modo/:token' => 'articles#newArticle'
  get '/articles/modify/:id/:nombre/:precio/:descripcion/:proveedor/:imagen/:modo/:token' => 'articles#modifyArticle'
  get '/articles/delete/:id/:token' => 'articles#deleteArticle'
  get '/articles/find/:cadena/:token' => 'articles#findArticle'

  get '/stores/add/:nombre/:latitud/:longitud/:direccion/:descripcion/:imagen' => 'stores#newStore'

  get '/scores/add/:calificado/:calificador/:calificacion/:token' => 'scores#newScore'
  get '/scores/indexscore/:id/:token' => 'scores#indexScore'
  get '/scores/modify/:id/:calificado/:calificador/:calificacion/:token' => 'scores#modifyScore'
  get '/scores/modify/:calificado/:calificador/:token' => 'scores#getScore'

  get '/comments/add/:articulo/:persona/:comentario/:token' => 'comments#newComment'

  get '/comments/mostrar/:articulo/:token' => 'comments#newMostrar'

end
