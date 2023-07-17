# README


A basic Monitoring application to get the information regarding Shares.

* Example:

    * Name: Reliance

    * Symbol: REL

    * Price: 1900.00

Application also triggers if any new shares is been added or updated to the Watchlist.


* Endpoints:

    * Creating Share

      > POST: {{url}}/shares

        ex: {{url}}/shares

        payload:
            {   
              "shares":{
                "name": "Tata Motors",
                "symbol": "TATA",
                "price": "100.0",
              }
            }

    * Updating Share Info

      > PATCH: {{url}}/shares/:id

        ex: {{url}}/shares/1

        payload:
            {   
              "shares":{
                "name": "Tata Motors",
                "symbol": "TATA",
                "price": "100.0",
              }
            }

* Third Party can subscribe to the Watch list and get notified when there is a addition or change in the Shares Info.

    > Create Subscription

      - POST: {{url}}/add/subscription

        ex: {{url}}/add/subscription

        payload:
            {
              "subscription": {
                "callback_url": "https://www.example.com"
              }
            }


   
   > To Get notified, 

      - Post Endpoint is needed (Where the alert will be sent) - validation added to check the thirdparty url to accept post method


* Project Setup:

    - Ruby --> ruby 3.1.2

    - Rails --> 7.0.6

    - Database --> MYSQL

    - Update user_name and password for the mysql in config/database.yml

    - bundle install

    - create config/database.yml
    
    - ask for master.key
    
    - rake db:create

    - rake db:migrate

    - rake db:seed // for creating Subscription records


* Run application:

    - rails server 

