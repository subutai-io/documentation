## OptDyn website - grav version

Migrating Subutai documentation website to a new one based on [Grav CMS](https://getgrav.org). To get set up:


1. Run your preferred web server with PHP and the extensions required by grav ([see here](https://www.booleanworld.com/install-grav-cms-debian-ubuntu/) for more info).
2. Clone this repository/branch.
3. Remove the file user/accounts/optdyn.yamlm if it is there.
4. Access the website in your browser. If prompted, create a new admin user.
5. Create needed folders:

'mkdir cache assets logs images user/data'

You're done! This website uses the [Learn2 Skeleton](https://github.com/hibbitts-design/grav-skeleton-learn2-with-git-sync/) and already has relevant plugins installed by default.