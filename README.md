# JSONlite

##### A simple, self-contained, serverless, zero-configuration, json document store.

JSONlite sandboxes the current working directory similar to SQLite. The JSONlite data directory by default is named `jsonlite.data` and each json document is validated and saved pretty printed as a uuid.

## Requirements

1. bash
2. uuidgen
3. python -m json.tool
  - Alternatively, install [yajl](http://lloyd.github.io/yajl/) for `json_reformat` *or* [jq](https://github.com/stedolan/jq) to get a significant performance improvement setting documents.

  `json_reformat` is the fastest of the three by far. `jq` comes in second and `python -m json.tool` is the slowest. If possible, avoid using `python -m json.tool`.

  Benchmark
    `tests/set_1k.bash`

    # MacBook Pro 16" M1 Max
    json_reformat: 6s
    jq: 19s
    python -m json.tool: 28s

## Installation

````shell
git clone https://github.com/nodesocket/jsonlite.git
ln -s "$PWD"/jsonlite/jsonlite.bash /usr/local/bin/jsonlite
````

## Configuration

You may optionally set the path to the data directory. It defaults to `$PWD/jsonlite.data` but can manually be set with the `JSONLITE_DATA_DIR` environment variable.

````shell
# default
export JSONLITE_DATA_DIR="$PWD"/jsonlite.data

# manually set the data directory
export JSONLITE_DATA_DIR=/tmp/jsonlite.data
````

## API/Commands

### set

> set \<json\> - Writes a json document and returns the document id

````
➜ jsonlite set '{"name":"John Doe","active":true,"permissions":{"read":true,"write":false}}'
666B81D6-3F8A-4D57-BA3F-11FA8FC47246
````

`set` also supports piping into it:

````
echo '{"key":"value"}' | jsonlite set
4472B861-4C10-4C0A-A63B-E5D45AA679C0
````

and reading from a file:

````
jsonlite set < file.json
9DF4DC1F-121E-46DC-B580-E1663B645AED
````

### get

> get \<document-id\> - Retrieves a json document by document id

````
➜ jsonlite get 666B81D6-3F8A-4D57-BA3F-11FA8FC47246
{
    "active": true,
    "name": "John Doe",
    "permissions": {
        "read": true,
        "write": false
    }
}
````

### count

> count - Total number of json documents in the database

````
➜ jsonlite count
293
````

### delete

> delete \<document-id\> - Deletes a json document by document id

````
➜ jsonlite delete 666B81D6-3F8A-4D57-BA3F-11FA8FC47246
````

### drop

> drop (--force) - Drops the database

````
➜ jsonlite drop
Drop database '/tmp/jsonlite.data'? [Y/n] Y
````

````
➜ jsonlite drop --force
````

### help

> help - Displays help

````
➜ jsonlite help
Usage: jsonlite command <command-specific-options>

  set <json>             Writes a json document and returns a document id
  get <document-id>      Retrieves a json document by document id
  count                  Total number of json documents in the database
  delete <document-id>   Deletes a json document by document id
  drop (--force)         Drops the database
  help                   Displays help
  version                Displays the current version

````

### version

> version - Displays the current version

````
➜ jsonlite version
1.1.5
````

### default

> default - Displays the current version, configuration, and help

```
➜ jsonlite
JSONlite 1.1.5
  json formatter: json_reformat (fastest)
  data directory: /tmp/jsonlite.data

Usage: jsonlite command <command-specific-options>

  set <json>             Writes a json document and returns a document id
  get <document-id>      Retrieves a json document by document id
  count                  Total number of json documents in the database
  delete <document-id>   Deletes a json document by document id
  drop (--force)         Drops the database
  help                   Displays help
  version                Displays the current version

```

## Changelog

https://github.com/nodesocket/jsonlite/blob/master/CHANGELOG.md

## Support, Bugs, And Feature Requests

Create issues here in GitHub (https://github.com/nodesocket/jsonlite/issues).

## Versioning

For transparency and insight into the release cycle, and for striving to maintain backward compatibility, JSONlite will be maintained under the semantic versioning guidelines.

Releases will be numbered with the follow format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

+ Breaking backward compatibility bumps the major (and resets the minor and patch)
+ New additions without breaking backward compatibility bumps the minor (and resets the patch)
+ Bug fixes and misc changes bumps the patch

For more information on semantic versioning, visit http://semver.org/.

## License & Legal

Copyright 2022 Justin Keller

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
