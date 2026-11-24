# Setting up your laptop

You need four things: Lean, the Mathlib library, an editor that talks to Lean, and ManimCE for the
animations. The website is optional and only needs Node.js. For the editor, this guide covers VS Code,
Doom Emacs and plain Emacs.

**What your laptop needs:** about 10 GB of free disk (Mathlib's prebuilt files are around 5 GB),
and 8 GB of RAM or more. If that's too much, skip to [No install](#no-install) at the end.

## 1. Lean

Install **elan**, Lean's version manager, by following the
[official install guide](https://lean-lang.org/install/) (on macOS and Linux it's one `curl`
command). Restart your terminal, then check: `elan --version`. Elan reads `learning/lean/lean-toolchain`
and downloads the right Lean version the first time you build.

## 2. This repository and Mathlib

```sh
git clone https://github.com/rokitds/formal-math.git
cd formal-math/learning/lean
lake exe cache get      # downloads prebuilt Mathlib, a few minutes
lake build              # should finish with only "declaration uses 'sorry'" warnings
```

`lake exe cache get` is the important step. Without it, Lean compiles Mathlib from scratch, which
takes hours. If `lake build` starts compiling thousands of Mathlib files, stop it and run
`lake exe cache get` again.

## 3. Your editor

Whichever editor you use, the test is the same: open
`learning/lean/LeanLearning/Week01/E01_Rewriting.lean`, put the cursor after any `by`, and you
should see the goal state (the lines ending in `⊢ ...`).

### VS Code

1. Install [VS Code](https://code.visualstudio.com/), then the **Lean 4** extension
   (publisher: leanprover) from the Extensions panel.
2. Open the `learning/lean` folder itself (File → Open Folder), not the whole repository, so
   VS Code finds the right Lean project.
3. The goal state appears in the **Lean Infoview** panel. If it doesn't, run
   "Lean 4: Show Infoview" from the command palette.

### Doom Emacs

Doom installs [lean4-mode](https://github.com/leanprover-community/lean4-mode), the Lean
community's Emacs package, from GitHub. It needs Emacs 29.1 or newer.

1. In `~/.config/doom/init.el` (or `~/.doom.d/init.el`), make sure `lsp` is enabled under
   `:tools`. Use plain `lsp`, not `(lsp +eglot)`, because lean4-mode is built on lsp-mode.
2. In `packages.el`, add:

   ```elisp
   (package! lean4-mode
     :recipe (:host github
              :repo "leanprover-community/lean4-mode"
              :files ("*.el" "data")))
   ```

   The `"data"` entry matters: it holds the abbreviation table for typing symbols.
   lean4-mode also needs `magit-section`. If `magit` is enabled under `:tools` you already
   have it. If not, add `(package! magit-section)` as well.
3. Optionally, in `config.el`, put the main commands on the local leader (`SPC m`):

   ```elisp
   (use-package! lean4-mode
     :commands lean4-mode)

   (map! :after lean4-mode
         :map lean4-mode-map
         :localleader
         "i" #'lean4-toggle-info      ; show or hide the goal state
         "b" #'lean4-lake-build       ; build the project with lake
         "r" #'lean4-refresh-file-dependencies) ; reload after editing an imported file
   ```

4. Run `doom sync` in a terminal, then restart Emacs.
5. Open a `.lean` file under `learning/lean`. The first time, lsp-mode asks which project the file
   belongs to. Choose the `learning/lean` folder, not the repository root.

### Plain Emacs

With Emacs 30 or newer, add this to your init file. It installs lean4-mode from GitHub and its
dependencies from MELPA:

```elisp
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(use-package lean4-mode
  :commands lean4-mode
  :vc (:url "https://github.com/leanprover-community/lean4-mode.git"
       :rev :last-release))
```

On Emacs 29, install `lsp-mode`, `dash` and `magit-section` from MELPA, then run
`M-x package-vc-install RET https://github.com/leanprover-community/lean4-mode RET`.
For Straight or Elpaca, see the
[lean4-mode README](https://github.com/leanprover-community/lean4-mode), and include the `"data"`
directory in the recipe.

### Using Lean in Emacs (Doom or plain)

| Keys | What it does |
|---|---|
| `C-c C-i` | Show or hide the `*Lean Goals*` buffer: the goal state at the cursor |
| `C-c C-p C-l` | Build the project with lake |
| `C-c C-d` | Reload after you change a file that this one imports |
| `C-c C-k` | Show how to type the symbol under the cursor |

Type symbols with backslash abbreviations: `\and` gives ∧, `\or` ∨, `\to` →, `\not` ¬,
`\all` ∀, `\ex` ∃, `\sub` ⊆, `\in` ∈, `\inter` ∩, `\union` ∪, `\|-` ⊢, `\a` α, `\N` ℕ, `\Z` ℤ.
In Doom these work in evil's insert state.

The Emacs goal buffer is plain text, so the few interactive widgets some Mathlib tactics show in
VS Code don't appear in Emacs. Nothing in this course needs them.

## 4. ManimCE

ManimCE needs Python 3.10 or newer, plus ffmpeg and two graphics libraries. The scenes in this
course use no LaTeX, so you can skip the LaTeX step in the ManimCE docs.

- **macOS:** `brew install py3cairo ffmpeg pango pkg-config`, then `pip install manim`.
- **Windows:** `pip install manim` usually works on its own. If not, install ffmpeg from
  [ffmpeg.org](https://ffmpeg.org/download.html) and try again.
- **Linux (Debian/Ubuntu):** `sudo apt install libcairo2-dev libpango1.0-dev ffmpeg`,
  then `pip install manim`.

Using a virtual environment is a good idea: `python3 -m venv .venv && source .venv/bin/activate`
before `pip install manim`. The full guide is at
[docs.manim.community](https://docs.manim.community/en/stable/installation.html).

Check it works:

```sh
cd learning/scenes
manim -pql goal_state.py GoalState
```

This renders a short 480p preview and opens it.

## 5. The website (optional)

With [Node.js](https://nodejs.org/) 22 or newer:

```sh
cd learning/site
npm install
npm run dev        # then open the address it prints
```

## No install

Every exercise sheet has an **Open in browser** button on the course site, which loads it into
[live.lean-lang.org](https://live.lean-lang.org), the official online editor with Mathlib. It's
slower than a local install, but it's a fine way to start.
