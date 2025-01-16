// @refresh reload
import { createHandler, StartServer } from "@solidjs/start/server";

import FavIcon from "~/assets/favicon.png";

export default createHandler(() => (
  <StartServer
    document={({ assets, children, scripts }) => (
      <html lang="en">
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width,initial-scale=1" />
          <meta name="theme-color" content="#353f4c" />
          <link rel="icon" href={FavIcon} />
          {assets}
        </head>
        <body>
          <div id="root" class="flex min-h-screen flex-col items-center justify-center px-8 py-12">
            {children}
          </div>
          {!import.meta.env.PROD && scripts}
        </body>
      </html>
    )}
  />
));
