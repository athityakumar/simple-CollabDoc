Rails.application.routes.draw do
  root to: 'session#create'

  get  '/session/create', 'session#create'
  post '/session/create', 'session#create'

  get  '/session/check', 'session#check'
  post '/session/check', 'session#check'

  get '/session/show', 'session#show'
  get '/session/destroy', 'session#destroy'

  get  '/template/upload', 'template#upload'
  post '/template/upload', 'template#upload'

  get  '/template/share', 'template#share'

  get  '/template/fill/:template_id', to: 'template#fill', as: 'template_fill'
  patch '/template/fill/:template_id', to: 'template#fill'

  get  '/document/share', 'document#share'
  post '/document/share', 'document#share'

  get '/document/show/:document_id', to: 'document#show', as: 'document_show'
  get '/document/sign/:document_id', to: 'document#sign', as: 'document_sign'
end
