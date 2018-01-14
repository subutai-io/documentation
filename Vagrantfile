
docs_port = 8000

Vagrant.configure("2") do |config|
  config.vm.box = "subutai/stretch"
  
  config.vm.network "forwarded_port", guest: 8000, host: 8000, 
    auto_correct: true

  config.vm.provision 'shell', 
    env: {
      "ACNG_HOST" => ENV['ACNG_HOST'],
      "ACNG_PORT" => ENV['ACNG_PORT'],
      "APPROX_HOST" => ENV['APPROX_HOST'],
      "APPROX_PORT" => ENV['APPROX_PORT']
      }, inline: <<-SHELL

    ## Need to make this conditional
    ACNG_URL="http://$ACNG_HOST:$ACNG_PORT"
    APPROX_URL="http://$APPROX_HOST:$APPROX_PORT/debian/"

    # Apt settings
    echo 'Using '$ACNG_URL' and '$APPROX_URL' for deb pkg caching'
    echo 'Acquire::http::Proxy "'$ACNG_URL'";' > /etc/apt/apt.conf.d/02proxy

    echo "Finding nearest apt mirror even when caching (not everything gets cached)"
    apt-get -y update
    apt-get install -y netselect-apt
    country=`curl -s ipinfo.io | grep country | awk -F ':' '{print $2}' | sed -e 's/[", ]//g'`
    if [ "KG" = "$country" ]; then
      country='KZ'
    fi

    netselect-apt -c $country &> /dev/null
    if [ ! "$?" = "0" ]; then
      netselect-apt -c US &> /dev/null
    fi

    if [ -f "sources.list" ]; then
      rm /etc/apt/sources.list

      while read line; do
        if [ -n "$(echo $line | egrep '^#.*')" -o -z "$(echo $line | grep '^deb .*')" ]; then
          continue;
        fi

        echo "$line non-free" >> /etc/apt/sources.list;
        echo "$line non-free" | sed -e 's/deb /deb-src /' >> /etc/apt/sources.list;
      done < sources.list
    fi

    apt-get -y update
    apt-get install -y git python python-pip python-dev build-essential
    pip install --upgrade pip
    pip install --upgrade virtualenv
    pip install sphinx sphinx-autobuild recommonmark

    # Before exiting in privileged mode setup iptables and routing
    # sphinx-autobuild does not listen on all interface just localhost
    sysctl -w net.ipv4.conf.enp0s8.route_localnet=1
    iptables -t nat -I PREROUTING -p tcp -d 172.16.0.0/16 --dport 8000 -j DNAT --to-destination 127.0.0.1:8000
  SHELL

  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    cd /vagrant/docs;
    nohup sphinx-autobuild . _build/html vagrant &
  SHELL
end
