import { defineConfig } from "astro/config";
import tailwindIntegration from "@astrojs/tailwind";
import mdx from "@astrojs/mdx";

export default defineConfig({
  compressHTML: true,
  integrations: [tailwindIntegration(), mdx()],
  site: "https://grace.kimbutler.xyz",
});
