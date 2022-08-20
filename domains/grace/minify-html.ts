import type { AstroIntegration } from "astro";
import { minify } from "html-minifier-terser";
import { join } from "node:path";
import { readFile, writeFile } from "node:fs/promises";

const MINIFY_OPTIONS = {
  collapseWhitespace: true,
  minifyJS: true,
  removeComments: true,
};

async function minifyHtmlFilePath(filePath: string): Promise<unknown> {
  const originalContents = await readFile(filePath, "utf-8");
  const minifiedContents = await minify(originalContents, MINIFY_OPTIONS);
  return writeFile(filePath, minifiedContents);
}

export default function createMinifyHTMLPlugin(): AstroIntegration {
  return {
    name: "graceminifyhtml",
    hooks: {
      "astro:build:done": async ({ routes, dir }) => {
        const { pathname: dirPathName } = dir;
        const htmlFilePaths = routes.map(({ component, pathname }) => {
          return component.endsWith("/pages/404.astro")
            ? join(dirPathName, "404.html")
            : join(dirPathName, pathname!, "index.html");
        });
        await Promise.all(htmlFilePaths.map(minifyHtmlFilePath));
      },
    },
  };
}
