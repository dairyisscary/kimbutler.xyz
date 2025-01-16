import { Title as SolidTitle } from "@solidjs/meta";

export function Title(props: { children?: string }) {
  return <SolidTitle>{props.children && `${props.children} | `}Grace Kim-Butler</SolidTitle>;
}
