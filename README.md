# M-Pire CMS Docker Image & Containers

A docker image configured to run M-Pire CMS installs; includes php 7.2, apache, mysql, phpmyadmin, and modules/extensions needed.

On first run or anytime the Docker image is modified, run `docker-compose up --build -d` to build the image and spin up the three containers. After that you can spin up the containers as needed with `docker-compose up -d` or using the Docker Desktop app.

Load up `http://localhost/phpinfo.php` to check versions and what's configured.

There are three containers included; `sites` which will house our installs, `mysql` which runs the database, and `phpmyadmin` for a little database gui if you don't want to use Sequel Pro.

## Usage

Clone M-Pire repos inside `./installs`. Apache maps `./` to `/var/www` so when modifying vhosts, remember the path will be `/var/www/installs/<client-site>`.

You will need to modify your hosts file for each new vhost added, it will look like `127.0.0.1 monkee-boy.test`.

Sequel Pro can be configured as Standard with `127.0.0.1` (host), `root` (username), `root` (password), and `13306` (port).

Duplicate `vhost-example.conf` as `vhost.conf` to set up your own hosts as needed.

To add a new site, modify the `vhost.conf` and create a new VirtualHost block. For this to be active stop the M-Pire containers and run `docker-compose up --build -d`.

To connect to the database from M-Pire, modify your db config to have `'host' => 'database'`. `database` is the name we gave our mysql container and it will connect to it. Yes, the naming is confusing.

Feel free to change the ports as needed if anything conflicts with other local setups. You might need to configure some port mapping or just access the installs using the port.

### TODO

* There is no reason to rebuild the image when modifying just the vhost. Need to create a little script that will connect to the container and create a new vhost similar to our previous Vagrant setup. This will speed that process up.
* The Docker Desktop app seems to max resources when running `yarn`. This doesn't seem to be anything specific to our setup as there are tons of github issues about the horrible performance of the desktop app on OS X. Using the desktop app is optional but we will continue to tweak settings to see if we can find a good spot.
* Clean up this readme.


## License

This repo is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)

<hr>

Handcrafted with ♥ in Austin, Texas by the [Monkee-Boy Troop](https://www.monkee-boy.com/who/the-troop/).

![Monkee-Boy](http://assets.monkee-boy.com/mboy-logo-tagline.jpg)
