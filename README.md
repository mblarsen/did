# did; a weekly journal :book:

> One week, one file; to keep yourself in the loop.

![example diary](https://user-images.githubusercontent.com/247048/66284798-db923580-e8f3-11e9-9010-589b849817db.png)

### Setup

Add the following to your `.bash_profile` or `.zshrc`:

```
source path/to/did/did.sh
```

### Usage

Files and headers are created automatically on the appropriate times.

```
Usage:

    did [cmd]

Commands:

    (no command)   : opens the current week-file en editor

    ls             : lists all week files
    grep <query>   : shows entries from newest to oldest, optionally filtering by query
```

### Options

* `DID_PATH` defaults to `$HOME/.did`
* `DID_EXT` defaults to `md` (markdown)
* `DID_EDITOR` defaults to `$VISUAL`
* `DID_EDITOR_PARAMS` empty by default

E.g. set `DID_EDITOR_PARAMS` to `normal Go` to have *vim* go to the end of the
document when opening the journal.

### Syntax highlights

Get [did.vim](https://github.com/mblarsen/did.vim).

## Disclaimer

This is not my idea. I found an article describing this approach. ~~However, I
cannot find it after my laptop was stolen. Please let me know if you think
you've found it (the article on the laptop).~~

UPDATE: Found it. Here is [the
article](https://marmelab.com/blog/2018/11/08/a-developers-diary.html) that
introduced the weekly journal to me.

The original script ~~was~~is bash based. I've replaced the most complicated
parts with small python helpers.
