# Setting up your laptop

You need three things: Lean (with VS Code), the Mathlib library, and ManimCE for the animations.
The website is optional and only needs Node.js.

**What your laptop needs:** about 10 GB of free disk (Mathlib's prebuilt files are around 5 GB),
and 8 GB of RAM or more. If that's too much, skip to [No install](#no-install) at the end.

## 1. Lean and VS Code

1. Install [VS Code](https://code.visualstudio.com/).
2. In VS Code, open the Extensions panel and install **Lean 4** (publisher: leanprover).
3. The extension offers to install **elan**, Lean's version manager. Accept. If it doesn't,
   follow the [official install guide](https://lean-lang.org/install/).
4. Restart VS Code and your terminal, then check: `elan --version`.

## 2. This repository and Mathlib

```sh
git clone https://github.com/rokitds/formal-math.git
cd formal-math
git checkout claude/project-thread-pnocm0     # the course branch, until it's merged
cd learning/lean
lake exe cache get      # downloads prebuilt Mathlib, a few minutes
lake build              # should finish with only "declaration uses 'sorry'" warnings
```

`lake exe cache get` is the important step. Without it, Lean compiles Mathlib from scratch, which
takes hours. If `lake build` starts compiling thousands of Mathlib files, stop it and run
`lake exe cache get` again.

Then open the `learning/lean` folder in VS Code (File → Open Folder), open
`LeanLearning/Week01/E01_Rewriting.lean`, and click after any `by`. The **Lean Infoview** panel
should show a goal. If it doesn't, run "Lean 4: Show Infoview" from the command palette.

Tip: open the `learning/lean` folder itself, not the whole repository, so VS Code finds the right
Lean project.

## 3. ManimCE

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

## 4. The website (optional)

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
