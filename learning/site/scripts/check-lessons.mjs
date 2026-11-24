// Fails the build when a lesson bypasses the components. See learning/CLAUDE.md.
// Runs automatically before `npm run build` (the "prebuild" script).
import { readdirSync, readFileSync } from "node:fs";
import path from "node:path";

const LESSONS = path.resolve(process.cwd(), "src/pages/lessons");

const RULES = [
  { re: /^\s*(```|~~~)/m, msg: "fenced code block: show Lean with <LeanExercise> or <LeanSheet>, never pasted code" },
  { re: /<pre[\s>]/i, msg: "raw <pre>: show Lean with <LeanExercise> or <LeanSheet>" },
  { re: /<video[\s>]/i, msg: "raw <video>: use <Scene>" },
  { re: /<iframe[\s>]/i, msg: "raw <iframe>: add a component for it instead" },
  { re: /live\.lean-lang\.org/, msg: "hand-made editor link: <LeanExercise> and <LeanSheet> build these" },
  { re: /<aside[\s>]|<blockquote[\s>]|^>\s/m, msg: "raw aside or blockquote: use <Callout>" },
  { re: /<style[\s>]|\sstyle=/i, msg: "inline styles: styling lives in components and layouts" },
];

const REQUIRED_FRONTMATTER = ["layout", "title", "week", "time", "summary"];

let failures = 0;
const files = readdirSync(LESSONS).filter((f) => f.endsWith(".mdx") || f.endsWith(".md"));

for (const file of files) {
  const src = readFileSync(path.join(LESSONS, file), "utf8");
  const fm = src.match(/^---\n([\s\S]*?)\n---/);
  const body = fm ? src.slice(fm[0].length) : src;

  if (!file.endsWith(".mdx")) {
    console.error(`${file}: lessons must be .mdx so they can use the components`);
    failures++;
  }
  for (const key of REQUIRED_FRONTMATTER) {
    if (!fm || !new RegExp(`^${key}:`, "m").test(fm[1])) {
      console.error(`${file}: frontmatter is missing "${key}"`);
      failures++;
    }
  }
  body.split("\n").forEach((line, i) => {
    for (const { re, msg } of RULES) {
      if (re.test(line)) {
        console.error(`${file}:${i + 1 + (fm ? fm[0].split("\n").length - 1 : 0)}: ${msg}`);
        failures++;
      }
    }
  });
}

if (failures) {
  console.error(`\n${failures} lesson rule violation(s). See learning/CLAUDE.md.`);
  process.exit(1);
}
console.log(`Lesson check passed (${files.length} lesson file(s)).`);
