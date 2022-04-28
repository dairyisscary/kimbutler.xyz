import tailwindIntegration from "@astrojs/tailwind";
import { defineConfig } from "astro/config";

import minifyHTML from "./minify-html";

export default defineConfig({
  integrations: [minifyHTML(), tailwindIntegration({})],
  site: "https://grace.kimbutler.xyz",
});
