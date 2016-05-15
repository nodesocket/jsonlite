# JSONlite

##### A simple, self-contained, serverless, zero-configuration, [json](http://www.json.org/) document store.

JSONlite sandboxes the current working directory just like [SQLite](https://www.sqlite.org/). The data directory is named `jsonlite.data`, and each json document is saved pretty printed as a uuid.

## Installation

```shell
git clone https://github.com/nodesocket/jsonlite.git
cd jsonlite
ln -s $PWD/jsonlite.bash /usr/local/bin/jsonlite
```

## Requirements

1. bash
2. uuidgen
3. python -m json.tool
  - Alternatively, install [yajl](http://lloyd.github.io/yajl/) for `json_reformat` *or* [jq](https://github.com/stedolan/jq) to get a roughly 3x performance improvement setting documents.

## Configuration

You may optionally set the path to the data directory. It defaults to `$PWD/jsonlite.data` but can manually be set with the `JSONLITE_PATH` environment variable.

```shell
# default
export JSONLITE_PATH=$PWD/jsonlite.data

# to temp
export JSONLITE_PATH=/tmp/jsonlite.data
```

## API

### set

> set \<json\> - Writes a json document and returns the document id

````shell
➜ jsonlite set '{"name":"John Doe","active":true,"permissions":{"read":true,"write":false}}'
666B81D6-3F8A-4D57-BA3F-11FA8FC47246
````

### get

> get \<document-id\> - Retrieves a json document by document id

````shell
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

````shell
➜ jsonlite count
293
````

### delete

> delete \<document-id\> - Deletes a json document by document id

````shell
➜ jsonlite delete 666B81D6-3F8A-4D57-BA3F-11FA8FC47246
````

### drop

> drop (--force) - Drops the database

````shell
➜ jsonlite drop
Drop database '/jsonlite.data'? [Y/n] Y
````

````
➜ jsonlite drop --force
````

### version

> version - Displays the current version

````shell
➜ jsonlite version
0.7.0
````

#### help

> help - Displays help

````
➜ jsonlite help
JSONlite 0.7.0
Usage: jsonlite command <command-specific-options>

  set <json>             Writes a json document and returns a document id
  get <document-id>      Retrieves a json document by document id
  count                  Total number of json documents in the database
  delete <document-id>   Deletes a json document by document id
  drop (--force)         Drops the database
  help                   Displays help
  version                Displays the current version

  For more information, see https://github.com/nodesocket/jsonlite

````

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

Copyright 2016 Justin Keller

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
