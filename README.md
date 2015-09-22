# jsonlite

##### A simple, self-contained, serverless, zero-configuration, [json](http://www.json.org/) document store.

## Installation

```
git clone https://github.com/nodesocket/jsonlite.git
cd jsonlite
ln -s ./jsonlite /usr/local/bin
```

## Requirements

1. uuidgen
2. python -m json.tool

## API

##### set

> set \<json\>

````
➜ jsonlite set '{"name":"John Doe"}'
666B81D6-3F8A-4D57-BA3F-11FA8FC47246
````

##### get

> get \<document-id\>

````
➜ jsonlite get 666B81D6-3F8A-4D57-BA3F-11FA8FC47246
{
    "name": "John Doe"
}
````

##### delete

> delete \<document-id\>

````
➜ jsonlite delete 666B81D6-3F8A-4D57-BA3F-11FA8FC47246
````

##### destroy

> destroy

````
➜ jsonlite destroy
Are you sure you want to destroy '/jsonlite/jsonlite.data' (y/n)? y
````

##### version

> version

````
0.1.0
````

## Changelog

https://github.com/nodesocket/jsonlite/blob/master/CHANGELOG.md

## Support, Bugs, And Feature Requests

Create issues here in GitHub (https://github.com/nodesocket/jsonlite/issues).

## Versioning

For transparency and insight into the release cycle, and for striving to maintain backward compatibility, jsonlite will be maintained under the semantic versioning guidelines.

Releases will be numbered with the follow format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

+ Breaking backward compatibility bumps the major (and resets the minor and patch)
+ New additions without breaking backward compatibility bumps the minor (and resets the patch)
+ Bug fixes and misc changes bumps the patch

For more information on semantic versioning, visit http://semver.org/.

## License & Legal

Copyright 2015 Justin Keller

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
