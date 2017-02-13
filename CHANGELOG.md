CHANGELOG
=========

## 1.1.0 - *2/12/2017*

- Fixed a bug where providing invalid json to `set` would write an empty file with a uuid filename to the data directory. Now, providing invalid json to `set` errors with no file written to the data directory.

## 1.0.0 - *2/12/2017* **(BREAKING CHANGE)**

- **(BREAKING)** Deprecated `JSONLITE_PATH` environment variable. Use `JSONLITE_DATA_DIR` instead.
- Added default command to `README.md` documentation.
- When there is no data directory and `drop` is invoked, hard code an exit code of `0` instead of using `$?`.
- Documentation cleanup.
- Bump copyrights to 2017.

## 0.8.0 - *5/15/2016*

- The `set` command now supports piping into it. Closes [issue #14](https://github.com/nodesocket/jsonlite/issues/14).

````
echo '{"key":"value"}' | jsonlite set
4472B861-4C10-4C0A-A63B-E5D45AA679C0
````
````
cat foobar.json | jsonlite set
9DF4DC1F-121E-46DC-B580-E1663B645AED
````

- Documentation cleanup.

## 0.7.1 - *5/15/2016*

- Running `jsonlite` with no command displays the current version, `JSONLITE_PATH` environment variable, and invokes the `help` command.

## 0.7.0 - *5/14/2016*

- Added a new command `count` which displays the total number of json documents in the database.
- Return exit codes changed to ovoid using `1` and `2` which are reserved. Closes [issue #13](https://github.com/nodesocket/jsonlite/issues/13).

````
0 => Success
3 => Invalid command
4 => Missing required argument json document
5 => Missing required argument document id
6 => Invalid argument document id
7 => Failure confirming drop
````

- Invoking `jsonlite` without any commands now invokes the `help` command.
- Updated the `drop` command confirmation prompt.
- Added a new test `tests/set_500.bash`.
- Documentation cleanup.

## 0.6.3 - *5/14/2016*

- Documentation cleanup. No code changes.

## 0.6.2 - *5/14/2016*

- Globally replaced text JSONLite to JSONlite *(lowercase l)*.
- Shellcheck and cleanup.
- Documentation cleanup.

## 0.6.1 - *9/26/2015*

- Documentation cleanup. No code changes. 

## 0.6.0 - *9/26/2015* (thanks [josegonzalez](https://github.com/josegonzalez))

- You can now define where the data directory path is using the `JSONLITE_PATH` environment variable. It defaults to the existing path, `$PWD/jsonlite.data`.

- JSONlite has been transformed such that it can be used as a library. To do so, simply source in all the methods at the top of your script.

- Support for [yajl](http://lloyd.github.io/yajl/) `json_reformat` and [jq](https://github.com/stedolan/jq) pretty printing when setting. JSONlite will automatically detect if you have either, if not, it falls back to `python -m json.tool`. `json_reformat` and `jq` provide roughly a 3x performance improvement setting documents.

- Added `help` command.

- Bashisms and best practice cleanup.

- Added `Makefile` and `.travis.yml`.

## 0.4.2 - *9/22/2015*

- Changed the regular expression in function `is_valid_uuid` to `^[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}$`.

- Changed test from 1,000 to 500 iterations.

## 0.4.1 - *9/22/2015* (thanks [cbgbt](https://github.com/cbgbt))

- Support distros where `uuidgen` is lowercase by forcing uppercase. `awk '{print toupper($0)}'`

## 0.4.0 - *9/22/2015*

- Renamed the `destroy` command to `drop`.

## 0.3.0 - *9/22/2015*

- Renamed `jsonlite` to `jsonlite.sh` to clearify it is a shell script.

- Updated the installation section in `README.md` related to creating the symbolic link. The new `ln` command is:

````
ln -s $PWD/jsonlite.sh /usr/local/bin/jsonlite
````

## 0.2.0 - *9/21/2015*

- `get` and `delete` are now idempotent. For example, if you call `get` and pass a uuid that doesn't exist, no error code is returned. Instead a **0** exit code is returned and nothing is written to `stdout`.

- Now validates document id arguments passed into `get` and `delete` via regex. If invalid, a exit code of **3** is returned. Closes [issue #1](https://github.com/nodesocket/jsonlite/issues/1).

- Return exit codes changed and standardized. 

````
0 => Success
1 => Missing required argument json document
2 => Missing required argument document id
3 => Invalid argument document id
4 => Failure confirming destroy
````
