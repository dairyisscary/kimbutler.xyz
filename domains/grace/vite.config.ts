import { solidStart } from "@solidjs/start/config";
import { nitroV2Plugin as nitro } from "@solidjs/vite-plugin-nitro-2";
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "vite";

export default defineConfig(({ mode }) => ({
  plugins: [
    solidStart({
      // We're SSG only with no scripts/hydration
      solid: { solid: { hydratable: mode !== "production" } },
    }),
    nitro({
      prerender: { crawlLinks: true, routes: ["/", "/404"] },
    }),
    tailwindcss(),
  ],
}));
