# Installation manual

1. Install ruby-2.4.1 (Shorter solution is to update by `brew upgrade ruby`, but the best practise is to install a Ruby version manager like RVM/Rbenv):

  1.1 RVM


  ```sh
  curl -sSL https://get.rvm.io | bash -s stable --ruby
  rvm install 2.4.1
  rvm use 2.4.1 --default
  ```

  1.2 Rbenv

  ```sh
  brew update
  brew install rbenv ruby-build

  echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
  source ~/.bash_profile
  
  rbenv install 2.4.1
  rbenv global 2.4.1
  ```

  Re-check your installed ruby version with `ruby -v`

2. Make sure rubygems is installed, with `gem -v`
3. Install bundler with `gem install bundler`
4. Install other dependencies with `bundle install`
5. Migrate the database model files to sqlite3 models, with `rake db:migrate`
6. Deploy Rails app locally, with `rails s`