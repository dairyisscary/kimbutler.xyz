import { defineConfig } from "astro/config";
import tailwindIntegration from "@astrojs/tailwind";
import mdx from "@astrojs/mdx";

export default defineConfig({
  integrations: [tailwindIntegration(), mdx()],
  site: "https://grace.kimbutler.xyz",
});
