# selectric-mode

[![MELPA](https://melpa.org/packages/selectric-mode-badge.svg)]
(https://melpa.org/#/selectric-mode) [![MELPA Stable]
(https://stable.melpa.org/packages/selectric-mode-badge.svg)]
(https://stable.melpa.org/#/selectric-mode)


Make your Emacs sound like a proper typewriter. Extremely useful if you
have a puny, silent, rubberish, non-clicky keyboard.

The sound of the typewriter was recorded by a person nicknamed
"secretmojo" and is available on
https://www.freesound.org/people/secretmojo/sounds/224012/ under a
Creative Commons license.

To install it, simply add it to your load-path, require it:

```elisp
(add-to-list 'load-path "~/.emacs.d/plugins/selectric-mode")
(require 'selectric-mode)
```

And then activate/deactivate with M-x `selectric-mode`. When it's
activated, you'll hear a typing sound for confirmation. When it
deactivates, you'll hear a carriage movement sound instead.

Alternatively, you can install it from [MELPA](https://melpa.org).

![selectric-mode on MELPA]
(https://raw.githubusercontent.com/wiki/rbanffy/selectric-mode/melpa.png)
