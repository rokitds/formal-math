// Helpers that read the real Lean exercise files, so the site always shows
// the code that `lake build` checks. Paths are relative to learning/lean/LeanLearning.
import { readFileSync } from "node:fs";
import path from "node:path";

const LEAN_ROOT = path.resolve(process.cwd(), "../lean/LeanLearning");
const REPO = "https://github.com/rokitds/formal-math/blob/main/learning/lean/LeanLearning";

export function readLean(file: string): string {
  const full = path.join(LEAN_ROOT, file);
  try {
    return readFileSync(full, "utf8");
  } catch {
    throw new Error(`Lean file not found: ${file} (looked in ${full})`);
  }
}

/** The `# Title` line from the file's module docstring. */
export function sheetTitle(src: string, file: string): string {
  const m = src.match(/^#\s+(.+)$/m);
  if (!m) throw new Error(`${file} has no "# Title" line in its module docstring`);
  return m[1].trim();
}

/** One `theorem` from a file, with the docstring directly above it, up to the next blank line. */
export function extractTheorem(src: string, name: string, file: string): string {
  const lines = src.split("\n");
  const start = lines.findIndex((l) => new RegExp(`^theorem ${name}(\\s|$)`).test(l));
  if (start < 0) throw new Error(`theorem ${name} not found in ${file}`);
  let first = start;
  if (start > 0 && lines[start - 1].trimEnd().endsWith("-/")) {
    first = start - 1;
    while (first > 0 && !lines[first].trimStart().startsWith("/--")) first--;
  }
  let end = start;
  while (end + 1 < lines.length && lines[end + 1].trim() !== "") end++;
  return lines.slice(first, end + 1).join("\n");
}

export function githubUrl(file: string): string {
  return `${REPO}/${file}`;
}

/** Opens the code in the official in-browser Lean editor, which has Mathlib. */
export function liveUrl(code: string): string {
  return `https://live.lean-lang.org/#code=${encodeURIComponent(code)}`;
}
