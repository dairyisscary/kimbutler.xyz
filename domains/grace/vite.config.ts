import { solidStart } from "@solidjs/start/config";
import tailwindcss from "@tailwindcss/vite";
import { nitro } from "nitro/vite";
import { defineConfig } from "vite";

export default defineConfig(({ mode }) => ({
  plugins: [
    solidStart({
      // We're SSG only with no scripts/hydration
      solid: { solid: { hydratable: mode !== "production" } },
    }),
    nitro({
      prerender: {
        crawlLinks: true,
        routes: ["/", "/404"],
        // ignore the mailto: entity link
        ignore: ["/&"],
      },
    }),
    tailwindcss(),
  ],
}));
