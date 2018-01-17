
docs_port = 8000

Vagrant.configure("2") do |config|
  config.vm.box = "subutai/stretch"
  config.vm.synced_folder ".", "/readthedocs", disabled: false
  config.vm.network "forwarded_port", guest: 8000, host: 8000, auto_correct: true

  config.vm.provision 'shell',
    env: {
      "ACNG_HOST" => ENV['ACNG_HOST'],
      "ACNG_PORT" => ENV['ACNG_PORT'],
      "APPROX_HOST" => ENV['APPROX_HOST'],
      "APPROX_PORT" => ENV['APPROX_PORT'],
      "GDRIVE_TOKEN_FILE" => ENV['GDRIVE_TOKEN_FILE'],
      "GDRIVE_RTD_ROOT" => ENV['GDRIVE_RTD_ROOT']
      }, inline: <<-SHELL

    # Tuck these away into the environment so they're available to synchronize
    echo "GDRIVE_RTD_ROOT=$GDRIVE_RTD_ROOT" >> /etc/environment

    ## Need to make this conditional
    ACNG_URL="http://$ACNG_HOST:$ACNG_PORT"
    APPROX_URL="http://$APPROX_HOST:$APPROX_PORT/debian/"

    # Apt settings
    echo 'Using '$ACNG_URL' and '$APPROX_URL' for deb pkg caching'
    echo 'Acquire::http::Proxy "'$ACNG_URL'";' > /etc/apt/apt.conf.d/02proxy

    if [ -f sources.list ]; then
      echo "Nearest mirror already set."
    else
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
    fi

    apt-get -y update
    apt-get install -y git python python-pip python-dev build-essential
    pip install --upgrade pip
    pip install --upgrade virtualenv
    pip install sphinx sphinx-autobuild recommonmark
    pip install sphinx_rtd_theme

    # Get the google drive client
    wget 'https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download' -O /usr/local/bin/gdrive >/dev/null 2>&1
    chmod +x /usr/local/bin/gdrive

    # This is huge, need libre office and ruby
    echo "Brace yourself this could take a while: libreoffice and word to markdown ruby install"
    apt-get install -y libreoffice ruby ruby-dev zlib1g-dev
    gem install word-to-markdown


    # Before exiting in privileged mode setup iptables and routing
    # sphinx-autobuild does not listen on all interface just localhost
    sysctl -w net.ipv4.conf.enp0s8.route_localnet=1
    iptables -t nat -I PREROUTING -p tcp -d 172.16.0.0/16 --dport 8000 -j DNAT --to-destination 127.0.0.1:8000
  SHELL
  
  if ENV['GDRIVE_TOKEN_FILE'].nil? && ARGV[1] == 'up'
    puts 'Cannot enable google drive client without a proper token file.'
    puts 'Set the path to the token file using the GDRIVE_TOKEN_FILE environment variable.'
    puts 'If you do not have a token file, then log into the VM and run \'gdrive about\''
    puts 'It will prompt you with a URL to go to and authenticate to get a verification code.'
    puts 'You provide this code, and it stores the bearer token in a token file.'
    puts 'Copy the bearer token file generated in the VM under /home/subutai/.gdrive with'
    puts 'the name \'token_v2.json\' to somewhere safe, like your hosts $HOME/.ssh and'
    puts 'set GDRIVE_TOKEN_FILE to its path. You can then reprovision using:'
    puts ''
    puts 'GDRIVE_TOKEN_FILE=$HOME/.ssh/token_v2.json vagrant provision'
    puts ''
    puts 'You can also export this environment variable to permanently set it in'
    puts 'your shell profile file. Then you do not have to provide this value on'
    puts 'every vagrant up commands.'
  else
    config.vm.provision 'file',
      source: File.expand_path(ENV['GDRIVE_TOKEN_FILE']), 
      destination: '/tmp/token_v2.json'
  end

  config.vm.provision 'shell', privileged: false, 
  env: {
    "ACNG_HOST" => ENV['ACNG_HOST'],
    "ACNG_PORT" => ENV['ACNG_PORT'],
    "APPROX_HOST" => ENV['APPROX_HOST'],
    "APPROX_PORT" => ENV['APPROX_PORT'],
    "GDRIVE_TOKEN_FILE" => ENV['GDRIVE_TOKEN_FILE'],
    "GDRIVE_RTD_ROOT" => ENV['GDRIVE_RTD_ROOT']
    }, inline: <<-SHELL

    if [ -f /tmp/token_v2.json ]; then
      mkdir $HOME/.gdrive
      mv /tmp/token_v2.json $HOME/.gdrive
      gdrive about
    else
      echo 'Google drive client could not initialize.'
      echo
      echo 'Setup bearer token file and re-provision with vagrant.'
      echo 'Will NOT attempt site generation or start sphinx auto '
      echo 'build daemon. See the following wiki for more information:'
      echo
      echo 'https://github.com/subutai-io/docs/wiki/Using-the-Vagrant-VM'
      echo
      echo 'Existing with non-zero status.'
      exit 1
    fi

    if [ -z "$GDRIVE_RTD_ROOT" ]; then
      echo 'Looks like you do not have your GDRIVE_RTD_ROOT'
      echo 'environment variable set. Searching for any folder'
      echo 'in your Google Drive named readthedocs:'
      echo

      GDRIVE_RTD_ROOT="$(gdrive list | grep readthedocs | cut -d' ' -f1)"
      if [ -n "$GDRIVE_RTD_ROOT" ]; then
        echo 'Found it! Using folder named 'readthedocs' with ID '$GDRIVE_RTD_ROOT
        echo 'Make these messages go away by adding the following to your profile:'
        echo 
        echo "export GDRIVE_RTD_ROOT='$GDRIVE_RTD_ROOT'"
        echo
      else 
        echo "Could not find any folder named 'readthedocs'. Please make sure"
        echo "to rename the root used to readthedocs. Exiting with non-zero status."
        echo 1
      fi
    else
      echo "GDRIVE_RTD_ROOT set to $GDRIVE_RTD_ROOT, checking folder name ..."
      FOLDER="$(gdrive list | grep $GDRIVE_RTD_ROOT | awk '{print $2}')"
      echo "GDRIVE_RTD_ROOT folder name = $FOLDER"
      if [ "$FOLDER" != "readthedocs" ]; then
        echo "The folder name associated with your GDRIVE_RTD_ROOT id is not"
        echo "named readthedocs. It is named '$FOLDER' instead. Please make"
        echo "sure you used the correct folder ID, or your folder is renamed."
        echo "It MUST be named 'readthedocs'. Exiting with non-zero status."
        exit 1
      fi
    fi

    # This will dump into /readthedocs if the folder in gdocs is named readthedocs
    gdrive download --recursive --force --path / $GDRIVE_RTD_ROOT

    cd /readthedocs;
    nohup sphinx-autobuild . _build/html vagrant &
  SHELL
end
