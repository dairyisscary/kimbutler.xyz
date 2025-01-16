import { A } from "@solidjs/router";
import type { JSX } from "solid-js";

import BackButton from "~/assets/back-button.svg";

export function WithFooter(props: { class?: string; children: JSX.Element }) {
  return (
    <>
      <main class={props.class}>{props.children}</main>
      <footer class="mt-8 text-center text-sm tracking-widest uppercase">
        &copy; Grace Kim-Butler 2018-present
      </footer>
    </>
  );
}

export function Content(props: { title: string; children: JSX.Element }) {
  return (
    <WithFooter>
      <div class="max-w-2xl rounded-lg bg-black/60 px-10 py-8">
        <div class="mb-7 flex items-center justify-between gap-3">
          <h1 class="w-max border-b pb-2 text-2xl tracking-widest uppercase">{props.title}</h1>
          <A
            href="/"
            class="flex h-9 w-9 items-center justify-center rounded-full transition-colors hover:bg-white/10"
          >
            <img class="size-[70%]" aria-hidden="true" src={BackButton} />
            <span class="sr-only">Back to Home</span>
          </A>
        </div>
        <div class="prose-content">{props.children}</div>
      </div>
    </WithFooter>
  );
}
