---
title: SICP in Emacs
date: 2023-06-07
date-modified: 2025-04-14
categories:
  - lisp
  - emacs
  - book
draft: false
aliases:
  - 20250327191659-148e
---
I recently began reading the notorious "Structure and Interpretation of Computer Programs" [@abelsonStructureInterpretationComputer2002], a.k.a. the _Wizard book_. I'm only on the first chapter, but I can already see its value and why it gets recommended so much.

From Wikipedia:

> Structure and Interpretation of Computer Programs (SICP) is a computer science textbook by Massachusetts Institute of Technology professors Harold Abelson and Gerald Jay Sussman with Julie Sussman. [...] It teaches fundamental principles of computer programming, including recursion, abstraction, modularity, and programming language design and implementation.
> [...]
> The book describes computer science concepts using Scheme, a dialect of Lisp. It also uses a virtual register machine and assembler to implement Lisp interpreters and compilers.

In this post, I aim to showcase my workflow for studying the book using Emacs [@stallmanEMACSExtensibleCustomizable1981]. Also, I will provide any resources that helped me get going. To study SICP, we need two things: The book and a Scheme implementation for the examples and exercises.

# Getting the book

Lucky for us, the book is freely distributed from MIT itself. It is available in [HTML](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/index.html) and [PDF](https://web.mit.edu/6.001/6.037/sicp.pdf). But, there is also a third format option and it is the one we're going to choose: the Texinfo format.

From the official GNU site[^fn:1]:

> Texinfo uses a single source file to produce output in a number of formats, both online and printed (HTML, PDF, DVI, Info, DocBook, LaTeX, EPUB 3). This means that instead of writing different documents for online information and another for a printed manual, you need write only one document.
>
> The Texinfo system is well-integrated with GNU Emacs.

That last line is what's important here. `info` files are essentially manuals in plain text. Emacs has a built-in mode for rendering such documents. By using the `info` format, we can read SICP from inside Emacs.

## Obtaining the `info` file

The `info` file can be retrieved in two methods:

1.  By installing the `sicp` MELPA package[^fn:2]

2.  By downloading the `info` file directly from [neilvandyke.org](https://www.neilvandyke.org/sicp-texi/) and installing it.
    1.  Download the `sicp.info.gz` file ([link](https://www.neilvandyke.org/sicp-texi/sicp.info.gz)) in your home directory.

    2.  Execute the following commands

        ```bash
        $ sudo cp ~/sicp.info.gz /usr/local/share/info/
        $ sudo chmod 644 /usr/local/share/info/sicp.info.gz
        $ sudo install-info /usr/local/share/info/sicp.info.gz /usr/local/share/info/dir
        ```

Now SICP will be available through Emacs! To access it, you need to open Emacs, type {{< kbd 'C-h i' >}} to go to the `*info*` top directory, type {{< kbd m >}} to search and type `sicp` to find the book. If everything went correctly, you should be greeted with something like this:

![SICP's table of contents in \`info\` format, viewed from within Emacs](sicp%20in%20emacs.png)

# Setting up Scheme

SICP's examples and exercises are all implemented in Scheme. Scheme is a Lisp dialect with many implementations. ~~SICP uses the [MIT-Scheme](https://www.gnu.org/software/mit-scheme/) implementation~~ Turns out GNU/MIT-Scheme is **not** fully compatible with the code in SICP ([source](https://www.reddit.com/r/sicp/comments/mf0j95/comment/gsljkkw/?utm_source=share&utm_medium=web2x&context=3)). Instead, we will use [Racket](https://racket-lang.org/). Racket offers the [SICP collection](https://docs.racket-lang.org/sicp-manual/), a Racket `#lang` that makes it fully compatible with the SICP code.

First, we need to install racket through our package manager. After that, the sicp collection can be downloaded like this:

```bash
$ raco pkg install sicp
```

That's it! Now, when we write a `.rkt` file that needs to be compatible with SICP all we need to do is add <span class="inline-src language-racket" data-lang="racket">`#lang sicp`</span> at the top of the file[^fn:3].

## Racket in Emacs

Personally, I recommend [racket-mode](https://github.com/greghendershott/racket-mode) for working with Racket in Emacs. Another popular choice is [geiser](https://github.com/emacsmirror/geiser), but its `geiser-racket` module seems to be unmaintained[^fn:4].

To install `racket-mode` using [elpaca](https://github.com/progfolio/elpaca/), add the following to your config file:

```lisp
(use-package racket-mode
  :elpaca t)
```

## Racket in Org-Babel

In case you choose to go the literate programming route (as I have) using Org-Mode, you will need to enable support for racket in org-babel. To do this, use the [emacs-ob-racket](https://github.com/hasu/emacs-ob-racket) package. Add the following to your config:

```lisp
(use-package ob-racket
  :elpaca (:type git :host github :repo "hasu/emacs-ob-racket"))
```

and then enable racket in your org-babel configuration.

```lisp
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp :tangle ./init.el . t)
   (C . t)
   (python . t)
   ...
   (racket . t)))
```

To be able to use the `sicp` package in org-babel code blocks, you need to add `:lang sicp` in the Org block, like so:

```org
 #+begin_src racket :lang sicp
 "Hello World!"
 #+end_src
```

Instead of adding that to every code block, you can add `#+property: header-args :lang sicp` to the start of your Org file. ~~This will be applied to _all_ code blocks in the file, so make sure you include only racket code blocks~~ This can be mitigated by specifying that these header-args are to be applied only to racket blocks, like so: `#+property: header-args:racket :lang sicp`.

# Result

After all this work, now we can finally start reading SICP. My so-far workflow consists of the book in the left window, a racket REPL in the top-right corner and my Org-Roam notes in the bottom-right corner.

![My SICP studying workflow](sicp%20workflow.png)

When it comes to the exercises, I use Org-Mode and Org-Babel to write the solutions in a literate programming style. The file is divided by chapter. Each exercise is included followed by its (hopefully correct) solution. (So far) I use a single `.org` file and export it to PDF. Also, all of the code blocks are exported to a `.rkt` file, with links to the corresponding position in the org file. All of these files can be found at [this repo](https://github.com/kchousos/SICP-solutions).

![My SICP solutions in literate programming](sicp%20literate%20notes.png)

# Miscellaneous tips

-   **Update 07/06/2023**: As [u/jherrlin](https://www.reddit.com/r/emacs/comments/143cyw3/comment/jna8ev2/?utm_source=share&utm_medium=web2x&context=3) on Reddit pointed out, the fact that SICP is in text format gives us the ability to leverage Emacs' built-in bookmarks feature. When you arrive to the end of your study session, just type {{< kbd 'C-x r m' >}} and a bookmark will be placed on the current line. You can search your bookmarks with {{< kbd 'C-x r b' >}} or list them with {{< kbd 'C-x r l' >}}.

    My tip is to name the bookmark the same each time (e.g. `sicp`). That way, when you re-create it in a later position, the old bookmark is discarded automatically. Also, if you run Emacs in daemon mode, I suggest to run {{< kbd M-x >}} `bookmark-save` after adding a bookmark, to make sure it has been saved.

[^fn:1]: <https://www.gnu.org/software/texinfo/>
[^fn:2]: <https://melpa.org/#/sicp>
[^fn:3]: when using the REPL, we need to first evaluate <span class="inline-src language-racket" data-lang="racket">`(require sicp)`</span> before evaluating anything else.
[^fn:4]: <https://lists.nongnu.org/archive/html/geiser-users/2022-06/msg00004.html>

<center>
<button class="tinylytics_kudos"></button>
</center>