import React from "react";
import { Helmet } from "react-helmet";

import Layout from "common/layout";
import Page from "common/page";
import CV from "./cv.pdf";

function About() {
  return (
    <Layout>
      <Page title="About">
        <Helmet>
          <title>About | Grace Kim-Butler</title>
        </Helmet>
        <p>
          I am an anthropologist of art and science, with a focus on how authenticity, expertise,
          and materiality come to matter through laboratory practice. My current book project
          examines how scientists develop technologies for the restoration of art and cultural
          heritage. In 2019-20, I was a Postdoctoral Fellow in the Scholars Program at the{" "}
          <a href="http://www.getty.edu/research/scholars/years/2019_2020.html">
            Getty Research Institute
          </a>{" "}
          in Los Angeles. I received my PhD in{" "}
          <a href="http://web.mit.edu/hasts/">
            History, Anthropology, and Science, Technology, and Society (HASTS) at MIT
          </a>{" "}
          in 2019.
        </p>
        <p>
          I am currently an{" "}
          <a href="https://www.acls.org/recent-awardees/acls-emerging-voices-fellows">
            ACLS Emerging Voices Postdoctoral Fellow
          </a>{" "}
          at Vanderbilt University, where I am helping to revise the curriculum of the Communication
          of Science and Technology program.
        </p>
        <p>
          My <a href={CV}>curriculum vitae</a> is also available for download.
        </p>
      </Page>
    </Layout>
  );
}

export default About;
