CHANGELOG
=========

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
