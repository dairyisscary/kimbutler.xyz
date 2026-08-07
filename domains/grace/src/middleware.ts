import { createMiddleware } from "@solidjs/start/middleware";
import { parse } from "node-html-parser";

export default createMiddleware([
  async function NoScriptOrHydration(event, next) {
    const response = await next();
    const parsed = parse(response as string);

    for (const tag of parsed.querySelectorAll("script, link[rel='modulepreload']")) {
      tag.remove();
    }

    for (const attributeName of ["data-hk", "data-sm"]) {
      for (const tag of parsed.querySelectorAll(`[${attributeName}]`)) {
        tag.removeAttribute(attributeName);
      }
    }

    return parsed.outerHTML;
  },
]);
