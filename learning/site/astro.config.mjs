import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";

// Published with GitHub Pages from the rokitds/formal-math repository.
export default defineConfig({
  site: "https://rokitds.github.io",
  base: "/formal-math",
  integrations: [mdx()],
});
