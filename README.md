# did; a weekly journal :book:

### Setup

Add to your bash or zsh script:

```
source path/to/did/did.sh
```

### Usage

```
did
```

and:

```
did ls
did ls something
```

To list or search journal.

### Options

* `DID_PATH` defaults to `$HOME/.did`
* `DID_EXT` defaults to `md` (markdown)
* `DID_EDITOR` defaults to `$VISUAL`
* `DID_EDITOR_PARAMS` empty by default

E.g. set `DID_EDITOR_PARAMS` to `normal Go` to have *vim* go to the end of the
document when opening the journal.

## Disclaimer

This is not my idea. I found an article describing this apporach. However, I
cannot find it after my laptop was stolen. Please let me know if you think
you've found it (the article on the laptop).

The orignal script was bash based. I've replaced the most complicated parts
with small python helpers.
