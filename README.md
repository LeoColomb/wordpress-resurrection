![elizabeth-lies-159004](https://user-images.githubusercontent.com/846943/36357938-fbb05f7c-1505-11e8-8ff6-5dd360106e22.jpg)

# WordPress Resurrection

> Back to youth

SQL scripts to cleanup an old WordPress database and recover a normal-sized
database.

**Warning: Please execute with care, scripts are destructives.**

## Usage

* Replace `#DB_PREFIX#` with the in-database prefix.
* Execute files, preferably in the right order.
  * Don't forget to select the targeted MySQL schema before!

## Goals

A WordPress database is often full of old data, either added by bad plugins
either added by old version of WordPress.
Sometimes the database grows so much, it exceeds a reasonable limit and require
a full review.

Personal usage:
* Old database: ~10 Go
* New database: ~10 Mo

## License

ISC © Léo Colombaro

Photo by elizabeth lies
