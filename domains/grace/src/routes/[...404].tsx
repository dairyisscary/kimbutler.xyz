import { A } from "@solidjs/router";

import { Content } from "~/layouts";
import { Title } from "~/meta";

export default function NotFound() {
  return (
    <Content title="Page not found">
      <Title>Not found</Title>
      <p>Unable to find this page (that&apos;s a 404!). Are you sure this is a valid link?</p>
    </Content>
  );
}
