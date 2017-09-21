[![Build Status](https://travis-ci.org/lflux/eve-sdeloader.svg?branch=master)](https://travis-ci.org/lflux/eve-sdeloader)
[![Test Coverage](https://codeclimate.com/github/lflux/eve-sdeloader/badges/coverage.svg)]

# eve-sdeloader

`eve-sdeloader` is a tool for importing an EVE static data export from [EVE Developer Resources](https://developers.eveonline.com/resource/resources) to a Postgresql database. 

# Current status

I won't even call this alpha, it can currently import the `invtypes` table. Currently tested on Go 1.9 with Postgres 9.6, but it probably works all the way back to 8.4.

# Usage

By default `eve-sdeloader` will try to import SDE files from under `./sde` to the database `sdetest` on localhost with the user `sdetest`. This is all overridable with CLI flags:

```
Usage of ./eve-sdeloader:
  -dbhost string
    	Database host (default "localhost")
  -dbname string
    	Database name (default "sdetest")
  -dbpassword string
    	Database password
  -dbport int
    	Database port (default 5432)
  -dbuser string
    	Database username (default "sdetest")
  -sdedirectory string
    	Directory containing an unzipped EVE SDE YAML dump (default "./sde")
```

## Profiling

`eve-sdeloader` accepts `-cpuprofile` and `-memprofile` flags to dump profiling
output from `runtime/pprof` into pprof files that can be consumed by other
tools.

# Installing 

`go get github.com/lflux/eve-sdeloader` should install the tool. If this fails, check out the repository under your `$GOPATH` and use [dep](https://github.com/golang/dep) to fetch the dependencies:

```bash
$ mkdir -p $GOPATH/src/github.com/lflux
$ cd $GOPATH/src/github.com/lflux
$ git clone https://github.com/lflux/eve-sdeloader.git
$ cd eve-sdeloader
$ dep ensure
$ go install .
```

The tool will be in `$GOPATH/bin/eve-sdeloader` (by default `GOPATH` is `~/go` as of Go 1.8)

# Database preparation

Easiest way to create a database for this tool is to connect to the database as a superuser and create a role that can log in, along with a database owned by that user:

```sql
CREATE ROLE sdetest LOGIN;
CREATE DATABASE sdtest OWNER sdetest;
```

# License

`eve-sdeloader` is copyright (c) 2017 Ian Delahorne and licensed under the MIT license, which can be found in the [LICENSE](LICENSE) file.
