# fugitive-extras

Additions to [vim-fugitive](https://github.com/tpope/vim-fugitive): review a
branch the way a pull request shows it, stage hunks in a vertical diff, and
leave review comments saved per branch.

**Vim or Neovim:** tested on Vim 9.1 and newer. It's plain Vimscript, so it may
work on Neovim, but that's untested.

## Install

```vim
Plug 'tpope/vim-fugitive'
Plug 'vimoured/fugitive-extras'
```

That gives you the diffs. Optional, each for the commands it adds:

| Also needs | Adds |
| --- | --- |
| [vim-lists](https://github.com/vimoured/vim-lists) | `:Compares`, `:BranchCommits` |
| [vim-place](https://github.com/vimoured/vim-place) | `:Comment`, `:Comments`, `:CommentsClear` |
| vim-place + [vim-draft](https://github.com/vimoured/vim-draft) | `:CommentDraft` |
| vim-place + [vim-review](https://github.com/vimoured/vim-review) | `:CommentsSave`, `:CommentsLoad` |

## Use

Diffs compare against the merge-base with the default branch, with the older
side on the left.

| Command | What it does |
| --- | --- |
| `:DiffThis` | The index against the work tree; `dp` stages a hunk. |
| `:DiffThis!` | This file at the merge-base against the work tree. |
| `:DiffCommit[!] [rev]` | This file as a commit changed it (default `HEAD`); `!` compares its parent with the work tree. |
| `:BranchDiff[!] [branch]` | One diff tab per file the branch changes; `!` uses the work tree. |
| `:DiffRefresh` | Redo the comparison in this tab. |
| `:DiffClose [name]` | Close a comparison's tabs. |
| `:Compares` | List the comparisons `:BranchDiff` opened. |
| `:BranchCommits [branch] [args]` | List the commits the default branch lacks. |

Review comments, in a quickfix list titled `Review`:

| Command | What it does |
| --- | --- |
| `:[range]Comment [text]` | Comment on a line or range. |
| `:[range]CommentDraft [text]` | Write the comment in a draft. |
| `:Comments` | Open the list; `c` edits the comment on the line. |
| `:CommentsSave [file]` | Save the comments, per branch without `file`. |
| `:CommentsLoad [file]` | Load comments, moved to where their lines are now. |
| `:CommentsClear` | Empty the list; saves are kept. |

Every command except `:Comments`, `:CommentsSave`, `:CommentsLoad` and
`:CommentsClear` has a `<Plug>` mapping to bind, for example:

```vim
nmap <leader>cd <Plug>(fugitive-extras-diff-main)
nmap <leader>cr <Plug>(fugitive-extras-diff-refresh)
nmap <leader>cl <Plug>(fugitive-extras-branch-commits)
nmap <leader>cc <Plug>(fugitive-extras-comment)
xmap <leader>cc <Plug>(fugitive-extras-comment)
```

## Tests

The specs in [vim-suite](https://github.com/vimoured/vim-suite) define what it
does: `test/fugitive-extras.vim`.
