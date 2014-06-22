MySQL Container
===============

Configure your MySQL data directory
-----------------------------------

    $ sudo make start
    $ sudo docker run --volume=/storage/mysql/data:/var/lib/mysql \
          --rm --tty --interactive imos/mysql /bin/bash
    # mysql_install_db --datadir=/var/lib/mysql
    # mysqld_safe &
    # mysql -u root
    mysql> GRANT ALL PRIVILEGES ON *.* TO your_username@localhost 
               IDENTIFIED BY 'your_password';
