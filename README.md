[![Build Status](https://travis-ci.org/genebean/hubot-tree-planter.svg?branch=master)](https://travis-ci.org/genebean/hubot-tree-planter)

# hubot-tree-planter

A hubot script for planting trees with tree-planter

See [`src/tree-planter.coffee`](src/tree-planter.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-tree-planter --save`

Then add **hubot-tree-planter** to your `external-scripts.json`:

```json
[
  "hubot-tree-planter"
]
```

## Environment Variables

For this to do you much good you are going to need to export some environment
variables to represent the source repos and destination
[tree-planter][tree-planter] instances.

Each variable should be named `HUBOT_TREExx` where the `xx`'s are replaced with
numbers. Their values should be made up of three parts separated by commas:

* source - the full url you'd use to clone your repository.
* destination - the base url for the tree-planter instance you are deploying to
* nickname - a name to reference this combo by made up of letters and dashes

### Examples

```bash
export HUBOT_TREE01='https://github.com/genebean/tree-planter.git,http://www01.example.com:8080,tree-planter-via-http'
export HUBOT_TREE02='git@github.com:genebean/tree-planter.git,http://app02.example.com:8080,tree-planter-via-ssh'
```

## Sample Interaction

```
user1>> hubot plant some_repo
hubot>> Planting some_repo on host.example.com...
```

## NPM Module

https://www.npmjs.com/package/hubot-tree-planter


[tree-planter]: https://hub.docker.com/r/genebean/tree-planter/
