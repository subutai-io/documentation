
docs_port = 8000

Vagrant.configure("2") do |config|
  config.vm.box = "subutai/stretch"
  config.vm.network "forwarded_port", guest: 8000, host: 8000, auto_correct: true

  config.vm.synced_folder ".", "/readthedocs", disabled: false

  config.vm.provider :kvm do |_, override|
    config.vm.synced_folder ".", "/readthedocs", disabled: false, nfs: true
  end  

  config.vm.provision 'shell',
    env: {
      "ACNG_HOST" => ENV['ACNG_HOST'],
      "ACNG_PORT" => ENV['ACNG_PORT'],
      "APPROX_HOST" => ENV['APPROX_HOST'],
      "APPROX_PORT" => ENV['APPROX_PORT']
      }, inline: <<-SHELL

    export DEBIAN_FRONTEND=noninteractive

    if [ -n "$ACNG_HOST" -a -n "$ACNG_PORT" ]; then
      ACNG_URL="http://$ACNG_HOST:$ACNG_PORT"

      # Apt settings
      echo 'Using '$ACNG_URL' for deb pkg caching'
      echo 'Acquire::http::Proxy "'$ACNG_URL'";' > /etc/apt/apt.conf.d/02proxy
    fi

    if [ -f /root/sphinx_installed ]; then
      echo "Python and Sphinx already installed ..."
    else
      apt-get -y update
      apt-get install -y git python python-pip python-dev build-essential
      pip install --upgrade pip==9.0.3
      pip install --upgrade virtualenv
      pip install sphinx sphinx-autobuild recommonmark
      pip install sphinx_rtd_theme
      touch /root/sphinx_installed
    fi

    if [ -f /root/converters_installed ]; then
      echo "Converters already installed ..."
    else
      apt-get install -y pandoc
      touch /root/converters_installed
    fi

    # Before exiting in privileged mode setup iptables and routing
    # sphinx-autobuild does not listen on all interface just localhost

    # sysctl -w net.ipv4.conf.enp0s8.route_localnet=1
    # iptables -t nat -I PREROUTING -p tcp -d 172.16.0.0/16 --dport 8000 -j DNAT --to-destination 127.0.0.1:8000
  SHELL

  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    cd /readthedocs
    ./build.sh

    # Generate the RTD site with auto build daemon
    # nohup sphinx-autobuild . _build/html vagrant &
  SHELL
end