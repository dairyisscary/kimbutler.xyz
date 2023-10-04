module.exports = {
  overrides: [
    { files: "*.astro", options: { parser: "astro" } },
    { files: "*.md", options: { printWidth: 120 } },
    { files: "*.mdx", options: { printWidth: 120 } },
  ],
  plugins: ["prettier-plugin-astro", "prettier-plugin-tailwindcss"],
  printWidth: 100,
  proseWrap: "always",
};
