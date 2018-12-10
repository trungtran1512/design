# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# design
======================================
config project to deploy server:
link cai dat: https://viblo.asia/p/huong-dan-deploy-ung-dung-ruby-on-rails-len-server-aws-ec2-su-dung-gem-capistrano-puma-va-nginx-Eb85oXDWK2G#_cai-dat-moi-truong-tren-server-8

  1. tao instance tren EC2
    https://docs.aws.amazon.com/efs/latest/ug/gs-step-one-create-ec2-resources.html

  2. ket noi instance voi EC2 tren server:
    - cap quyen view cho key pair vua download:
      $ chmod 400 new_key_pair_design.pem
    - chay lenh de connect instance:
        $ ssh -i "new_key_pair_design.pem" ubuntu@54.244.57.100
        $ ubuntu@ip-172-31-27-101:~$

  3. tao user de deploy:
    - ubuntu@ip-172-31-27-101:~$ sudo adduser <new_user>
    - dung lenh: sudo su - <new_user> (de chuyen user)

  4. cap quyen sudo cho new_user
    - exit sang server ubuntu mac dinh: sudo nano /etc/sudoers
    - them dong nay vao: %design ALL=(ALL) ALL (sau do save lai)

  5. thiet lap ssh authentication (ket noi truc tiep user design ma khong thong qua user ubuntu mac dinh)
    - $ mkdir .ssh
    - $ sudo chmod 700 .ssh
    - $ nano ~/.ssh/authorized_keys
    - $ sudo chmod 600 ~/.ssh/authorized_keys
    - tao ssh public key/private key duoi local ==> doi public key len authorized_keys
        $ ssh-keygen -t rsa -C <local_name> (neu da co roi thi bo qua)
    - chay cau lenh: $ cat ~/.ssh/id_rsa.pub (de lay public key va copy vao authorized_keys)
    - copy vao authorized_keys tren server va save lai.
    - tu may local ==> $ ssh design@54.244.57.100 hoac $ ssh design@ec2-54-244-57-100.us-west-2.compute.amazonaws.com

  6. cai dat moi truong tren server:
    - cai dat ruby:
      $ sudo apt-get install curl
    - cai dat cac dependencies cho Ruby
      $ sudo apt-get install zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
    - cai dat RVM
      $ sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
      $ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
      $ curl -sSL https://get.rvm.io | bash -s stable
      $ source ~/.rvm/scripts/rvm
    - cai dat RUBY
      $ rvm install 2.5.3
      $ rvm default use 2.5.3
    - cai dat RAILS framework
      $ gem install rails --version 5.2.1 --no-ri --no-rdoc
    - cai dat server cho ung dung RAILS
      $ curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
      $ sudo apt-get install -y nodejs
    - cai dat MYSQL
      $ sudo apt-get install mysql-server mysql-client libmysqlclient-dev
      * config va tao database va user cho MYSQL
        $ mysql -u root -p
        $ create database design_db;
        $ create user 'design'@localhost' identified by 'design'; (tao user va password)
        $ grant all privileges on *.* to 'design'@'localhost';
    - cai dat GIT
      $ sudo apt-get install git

  7. cau hinh project
    - su dung gem Capitrano de deploy (sau do chay $ bundle install)
      gem "capistrano"
      gem "capistrano3-puma"
      gem "capistrano-rails", require: false
      gem "capistrano-bundler", require: false
      gem "capistrano-rvm"
    - sau do chay lenh:
      $ cap install (sinh ra cac file deploy.rb, deploy/staging.rb, deploy/production.rb,...)
    - mo file deploy.rb (duoi local)
        # config valid only for current version of Capistrano
        lock "3.10.0"
        set :application, "design"
        set :repo_url, "git@github.com:trungpro152224/design.git"
        set :pty, true
        set :linked_files, %w(config/database.yml config/application.yml)
        set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)
        set :keep_releases, 5
        set :rvm_type, :user
        set :puma_rackup, -> {File.join(current_path, "config.ru")}
        set :puma_state, -> {"#{shared_path}/tmp/pids/puma.state"}
        set :puma_pid, -> {"#{shared_path}/tmp/pids/puma.pid"}
        set :puma_bind, -> {"unix://#{shared_path}/tmp/sockets/puma.sock"}
        set :puma_conf, -> {"#{shared_path}/puma.rb"}
        set :puma_access_log, -> {"#{shared_path}/log/puma_access.log"}
        set :puma_error_log, -> {"#{shared_path}/log/puma_error.log"}
        set :puma_role, :app
        set :puma_env, fetch(:rack_env, fetch(:rails_env, "staging"))
        set :puma_threads, [0, 8]
        set :puma_workers, 0
        set :puma_worker_timeout, nil
        set :puma_init_active_record, true
        set :puma_preload_app, false
      - mo file production.rb
        set :stage, :production
        set :rails_env, :production
        set :deploy_to, "/deploy/apps/design"
        set :branch, :develop
        server "54.244.57.100", user: "design", roles: %w(web app db)

  8. cap quyen ssh cho Server vao git repo
    - tao ssh keygen tren server:
      $ ssh-keygen -t rsa -C "design"
    - copy public key vao Deploy keys cua project tren github

  9. cau hinh NGINX tren server
    - intasll nginx
      $ sudo apt-get install nginx
    - remove gia tri mac dinh
      $ sudo rm /etc/nginx/sites_enabled/default
    - tao file default.conf
      $ sudo nano /etc/nginx/conf.d/default.conf
    - copy dong sau vao default.conf (sua lai dong server unix va duong dan root)
          upstream app {
         # Path to Puma SOCK file, as defined previously
         server unix:/deploy/apps/design/shared/tmp/sockets/puma.sock fail_timeout=0;
       }
       server {
         listen 80;
         server_name localhost;
         root /deploy/apps/design/current/public;
         try_files $uri/index.html $uri @app;
         location / {
           proxy_set_header X-Forwarded-Proto $scheme;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header Host $host;
           proxy_redirect off;
           proxy_set_header Connection '';
           proxy_pass http://app;
           proxy_read_timeout 150;
         }
         location ~ ^/(assets|fonts|system)/|favicon.ico|robots.txt {
           gzip_static on;
           expires max;
           add_header Cache-Control public;
         }
         error_page 500 502 503 504 /500.html;
         client_max_body_size 4G;
         keepalive_timeout 10;
       }

    - chay len de restart nginx
      $ sudo service nginx restart

  10. tao cau truc thu muc deploy
      $ mkdir /deploy
      $ mkdir /deploy/apps
      $ mkdir /deploy/apps/design
      $ sudo chown -R design:root /deploy/apps/design
      $ mkdir /deploy/apps/design/shared
      $ mkdir /deploy/apps/design/shared/config
      $ nano /deploy/apps/design/shared/config/database.yml
    - sua file database.yml
        production:
        adapter: mysql2
        encoding: utf8mb4
        pool: 5
        database: design_db
        username: design
        password: design
        socket: /var/run/mysqld/mysqld.sock
    - them file application.yml trong config server
      $ nano /deploy/apps/design/shared/config/application.yml
    - tao secret key duoi local bang lenh: (file secret sinh ra roi copy vao application.yml)
      $ RAILS_ENV=production rails secret
      (example secret key: 28b909950168e26a477f38696b8c9ad0311b185bdbdde19eefe7e4771b0c2b5a4f2107fd4769770455c8bbb2e64d7abe98ad32376e8807a2bd5247825395e3e6)
    - add secret key vao bien moi truong tren server
      $ sudo nano ~/.bashrc
    - them dong nay vao ~/ .bashrc
      export SECRET_KEY_BASE="28b909950168e26a477f38696b8c9ad0311b185bdbdde19eefe7e4771b0c2b5a4f2107fd4769770455c8bbb2e64d7abe98ad32376e8807a2bd5247825395e3e6"
    - source lai file
      $ source `/.bashrc`

  11. mo port 80  tren EC2
    - vao security groups ==> Inbound ==> http ==> port 80

  12. deploy
    $ cap production deploy


** Loi thuong gap:
  a. SSHKit::Runner::ExecuteError: Exception while executing as design@54.244.57.100: bundle exit status: 127
    require 'capistrano/rvm'
  b. puma not start in server
    $ install_plugin Capistrano::Puma
    $ install_plugin Capistrano::Puma::Nginx
