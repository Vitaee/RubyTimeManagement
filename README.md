## Ruby Time Management Project 
This is my first ruby on rails project. I learned a lot about the framework, while developing this. Steps are necessary to get the application up and running.

### Things you may want to cover:
* System information
    - Ubuntu 22.04.1 LTS 64-bit

* Ruby version
    - ruby 3.0.4p208 (2022-04-12 revision 3fa771dded) [x86_64-linux]
    - Rails 7.0.4

* Configuration
    - create docker postgresql and our database with these commands:
    ```.bash 
        sudo docker run --name some-postgres -e POSTGRES_PASSWORD=123456 -d postgres
        sudo docker exec -it some-postgres psql -U postgres -c "create database time_management_development" 
    ```
    - Our database is ready to use. So know, install dependencies with bundle.
    - ```bundle install```
    - create .env in project root and put your variables to .env file
    ```.env
    DB_HOST=172.17.0.2
    DB_USER=postgres
    DB_PASSWORD=123456
    DB_HOST=172.17.0.2
    DB_PORT=5432
    ```
    - The last step before ```rails s``` is migrating our tables, please run this command ```rails db:migrate```
    

### Example video shows demo about the application.
[![Watch the video](https://i.ibb.co/x6Wvf1j/denemee.png)](https://streamable.com/e/ud3udl)
