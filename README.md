# CARD AND ACTION CABLE

### Setup

* `$ rvm install 2.6.6`
* `$ rvm 2.6.6@rails6`
* `$ gem install rails -v 6.1.4`
* `$ gem install sidekiq`
* `$ bundle install`
* `$ rails db:migrate`
* `$ rails s`

##### Страница localhost:3000/cards
выводится список карт

##### Страница localhost:3000/quests
на данной странице происходит опрос по картам.
поле вариант для варианта перевода.
после ввода варианта нужно нажать кнопку `check`
запрос пройдя через сервер отобразит перевод.
после чего пользователь должен нажать `checkbox` если вариант совпадает с переводом.
После провденых выше шагов нужно нажать кнопку `apply`, сервер по правильности перевода установит
следующий интервал для отображения карты и запустит фоновую задачу по данному интервалу.

