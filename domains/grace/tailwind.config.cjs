const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: ["./src/**/*.{astro,md,tsx,ts}"],
  theme: {
    extend: {
      fontFamily: {
        title: ["Raleway", ...defaultTheme.fontFamily.sans],
      },
      letterSpacing: {
        widest: ".2em",
      },
    },
  },
};
