#!/bin/bash
echo "
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-10-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo dnf -qy module disable postgresql
sudo dnf install -y postgresql17-server
sudo /usr/pgsql-17/bin/postgresql-17-setup initdb
sudo systemctl enable postgresql-17
sudo systemctl start postgresql-17
" > /tmp/pg.sh

chmod +x /tmp/pg.sh
sh /tmp/pg.sh

sudo touch /var/lib/pgsql/.pgsql_profile
sudo chmod 755 /var/lib/pgsql/.pgsql_profile
sudo chown postgres: /var/lib/pgsql/.pgsql_profile

echo '
alias lt="ls -ltrh"
alias lta="ls -ltrha"
alias cl="clear"
alias lk="ps -ef | grep "
alias lki="ps -ef | grep "
export PATH=/usr/pgsql-15/bin/:$PATH
' | sudo tee -a /var/lib/pgsql/.pgsql_profile > /dev/null
