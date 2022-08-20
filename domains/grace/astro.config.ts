import { defineConfig } from "astro/config";
import tailwindIntegration from "@astrojs/tailwind";
import mdx from "@astrojs/mdx";

import minifyHTML from "./minify-html";

export default defineConfig({
  integrations: [minifyHTML(), tailwindIntegration(), mdx()],
  site: "https://grace.kimbutler.xyz",
});
