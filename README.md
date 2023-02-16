# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:
<!--
* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->

* Cloner le projet à partir de l'adresse :
https://github.com/christophe126/ilek

* Une fois le projet deployé localement, il faut initialliser la base de données :
rails db:create
rails db:migrate


* Pour les datas, il faut lancer :
 "rails db:seed"
 Le programme va scrapper en automatique les deux premieres pages des vins rosés.


* lancer le serveur "bin/dev"


* Optionnel : Il est possible de scrapper les vins aux couleurs différentes avec la constante suivante (app/services/scrap_wine.rb) :

Si vous souhaitez rouges il faudra modifier
FILTER_COLOR  = '&filters[color][1]=1'

Et pour les blancs par exemple :
FILTER_COLOR  = '&filters[color][6]=6'

et relancer  "rails db:seed"
