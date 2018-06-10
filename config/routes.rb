Rails.application.routes.draw do
  get 'main/index'

  resources :comments
  resources :scores
  devise_for :admins
  resources :users
  resources :stores
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'

  get '/users/add/:nombre/:primerapellido/:segundoapellido/:correo/:password/:foto' => 'users#newUser'
  get '/articles/add/:nombre/:precio/:descripcion/:proveedor/:imagen/:modo/:token' => 'articles#newArticle'
  get '/stores/add/:nombre/:latitud/:longitud/:direccion/:descripcion/:imagen' => 'stores#newStore'
  get '/scores/add/:calificado/:calificador/:calificacion/:token' => 'scores#newScore'
  get '/comments/add/:articulo/:persona/:comentario/:token' => 'comments#newComment'

end
