import { A } from "@solidjs/router";
import type { JSX } from "solid-js";
import { ssr } from "solid-js/web";

import Avatar from "~/assets/avatar.png";
import Avatar2x from "~/assets/avatar@2x.png";
import { WithFooter } from "~/layouts";
import { Title } from "~/meta";

const LINK_CLX =
  "flex h-10 flex-1 items-center justify-center px-6 py-3 text-sm tracking-widest uppercase hover:bg-white/10";

const CONTACT_HREF = ["mailto:", "website", ".", "unfailing353", "@", "passmail.net"]
  .flatMap((section) => section.split("").map((c) => `&#${c.charCodeAt(0)};`))
  .join("");
const CONTACT_LINK = ssr(
  `<a class="${LINK_CLX}" href="${CONTACT_HREF}">Contact</a>`,
) as unknown as JSX.Element;

function Line() {
  return <div aria-hidden="true" class="h-12 w-px bg-white" />;
}

export default function Home() {
  return (
    <WithFooter class="flex flex-col items-center text-center">
      <Title />
      <picture class="block size-[120px] overflow-hidden rounded-full border border-white">
        <source
          media="(-webkit-min-device-pixel-ratio: 2), (min-resolution: 192dpi)"
          srcset={Avatar2x}
        />
        <img src={Avatar} alt="Headshot of Grace" />
      </picture>
      <Line />
      <div class="border-t border-b border-white px-10 py-14">
        <h1 class="mb-6 text-3xl tracking-widest uppercase">Grace Kim-Butler</h1>
        <p class="text-sm tracking-widest text-pretty uppercase">
          Anthropologist of Art and Science
        </p>
        <p class="mt-1 text-sm tracking-widest text-pretty uppercase">
          Postdoctoral Researcher at Utrecht University
        </p>
      </div>
      <Line />
      <nav class="mx-8 flex flex-col rounded border border-white sm:flex-row">
        <A class={LINK_CLX} href="/about/">
          About
        </A>
        <A class={LINK_CLX} href="/research/">
          Research
        </A>
        <A class={LINK_CLX} href="/writing/">
          Writing
        </A>
        {CONTACT_LINK}
      </nav>
    </WithFooter>
  );
}
