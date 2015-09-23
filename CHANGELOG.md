CHANGELOG
=========

## 0.4.3 - *9/23/2015*

-  Using `json_reformat` from [YAJL](http://lloyd.github.io/yajl/yajl-2.0.1/reformatter_2json_reformat_8c-example.html) instead of `python -m json.tool` to pretty print json.

## 0.4.2 - *9/22/2015*

- Changed the regular expression in function `is_valid_uuid` to `^[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}$`.

- Changed test from 1,000 to 500 iterations.

## 0.4.1 - *9/22/2015*

- Support distros where `uuidgen` is lowercase by forcing uppercase. `awk '{print toupper($0)}'` Thanks [cbgbt](https://github.com/cbgbt).

## 0.4.0 - *9/22/2015*

- Renamed the `destroy` command to `drop`.

## 0.3.0 - *9/22/2015*

- Renamed `jsonlite` to `jsonlite.sh` to clearify it is a shell script.

- Updated the installation section in `README.md` related to creating the symbolic link. The new `ln` command is:

````
ln -s $PWD/jsonlite.sh /usr/local/bin/jsonlite
````

## 0.2.0 - *9/21/2015*

- `get` and `delete` are now idempotent. For example, if you call `get` and pass a uuid that doesn't exist, no error code is returned. Instead a **0** status code is returned and nothing is written to `stdout`.

- Now validates document id arguments passed into `get` and `delete` via regex. If invalid, a status code of **3** is returned. Closes [issue #1](https://github.com/nodesocket/jsonlite/issues/1).

- Return status codes changed and standardized.

````
0 => Success
1 => Missing required argument json document
2 => Missing required argument document id
3 => Invalid argument document id
4 => Failure confirming destroy
````
