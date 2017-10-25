[![Build Status](https://travis-ci.org/lflux/eve-sdeloader.svg?branch=master)](https://travis-ci.org/lflux/eve-sdeloader)
[![Test Coverage](https://codeclimate.com/github/lflux/eve-sdeloader/badges/coverage.svg)](https://codeclimate.com/github/lflux/eve-sdeloader/coverage)

# eve-sdeloader

`eve-sdeloader` is a tool for importing an EVE static data export from [EVE
Developer Resources](https://developers.eveonline.com/resource/resources) to a
Postgresql database. 

# Installing

`go get github.com/lflux/eve-sdeloader` should install the tool. If this fails,
check out the repository under your `$GOPATH` and use
[dep](https://github.com/golang/dep) to fetch the dependencies:

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

Easiest way to create a database for this tool is to connect to the database as
a superuser and create a role that can log in, along with a database owned by
that user:

```sql
CREATE ROLE sdetest LOGIN;
CREATE DATABASE sdtest OWNER sdetest;
```

# Usage

```bash
$ cd /tmp
$ unzip ~/Downloads/sde-20171024-TRANQUILITY.zip
$ curl -O https://raw.githubusercontent.com/fuzzysteve/yamlloader/master/invVolumes1.csv # or copy from this repo
$ curl -O https://raw.githubusercontent.com/fuzzysteve/yamlloader/master/invVolumes2.csv # or copy from this repo
# One entry needs fixing due to YAML vagaries
$ gsed -i -e 's/radius: 0.0059e18/radius: 0.0059e\+18/' sde/fsd/universe/wormhole/G-R00031/G-C00311/constellation.static
$ eve-sdeloader
```

By default `eve-sdeloader` will try to import SDE files from under `./sde` and
`./invVolumes{1,2}.csv` to the database `sdetest` on `localhost` with the user
`sdetest`. This is all overridable with CLI flags:

```
Usage of ./eve-sdeloader:
  -cpuprofile string
    	File to write cpu profile to
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
  -invvoldirectory string
    	Directory containing invVolumes{1,2}.csv (default ".")
  -memprofile string
    	File to write memory profile to
  -nobsd
    	Disable importing of BSD directory
  -nouniverse
    	Disable importing of universe data
  -sdedirectory string
    	Directory containing an unzipped EVE SDE YAML dump (default "./sde")
  -single-file string
    	Import only a single FSD file
```

# Current status

Import works with Postgres and is 99% compatible with the importer from
@fuzzysteve. A full import currently takes about 7 minutes on a Macbook Pro (to
contrast with 48 minutes for the python importer). The [TODO](TODO.md)
file attempts to keep track of project status.

Currently tested on Go 1.9 with Postgres 9.6 on OSX 10.12 (Sierra), but it
probably works all the way back to Postgres 8.4 and should work fine on Linux.

# Differences from the Python importer
- Negative 0 floats are imported as `-0`, whereas the python importer treats
  both as 0
- `invtraits` has different traitids due to insertion order. We attempt to keep
  these mostly the same by sorting types and skills, but the python importer
  doesn't sort at all and uses whatever order python map iteration gives you.

# Profiling

`eve-sdeloader` accepts `-cpuprofile` and `-memprofile` flags to dump profiling
output from `runtime/pprof` into pprof files that can be consumed by other
tools.

# Issues

Please raise issues on [Github](https://github.com/lflux/eve-sdeloader/issues).

# License

`eve-sdeloader` is copyright (c) 2017 Ian Delahorne and licensed under the MIT
license, which can be found in the [LICENSE](LICENSE) file.
