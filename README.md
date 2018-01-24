== README

## Liberty Hawk
Liberty Hawk is an app that allows you to congressional bill information on legislation that affects you. It uses the ProPublica API. 

#### Ruby version 
2.3.4p301

#### Rails version
4.2.5


## Setup 

#### Clone the repository  

#### Database creation
'sqlite3' gem for the Development database
'bundle install --without production'
'rake db:create' to create the database 

#### Database initialization
'rake db:migrate' to run migrations and seed

#### Deployment instructions
'rails s'
