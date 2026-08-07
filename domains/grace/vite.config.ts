import { solidStart } from "@solidjs/start/config";
import tailwindcss from "@tailwindcss/vite";
import { nitro } from "nitro/vite";
import { defineConfig } from "vite";

export default defineConfig(({ mode }) => ({
  plugins: [
    solidStart({
      middleware: mode === "production" ? import.meta.resolve("./src/middleware.ts") : undefined,
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
