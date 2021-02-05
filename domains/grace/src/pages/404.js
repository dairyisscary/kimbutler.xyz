import React from "react";

import Layout from "common/layout";
import Page from "common/page";

function FourOhFour() {
  return (
    <Layout>
      <Page title="Page Not Found">
        <div>
          <p>Unable to find this page (that&apos;s a 404!). Are you sure this is a valid link?</p>
        </div>
      </Page>
    </Layout>
  );
}

export default FourOhFour;
