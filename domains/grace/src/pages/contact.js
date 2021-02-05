import React from "react";
import { Helmet } from "react-helmet";
import { styled } from "styletron-react";

import { FormButton, TextArea, Input, FieldLabel } from "common/form";
import Layout from "common/layout";
import Page from "common/page";

const Fields = styled("div", {
  display: "flex",
});
const Field = styled("div", {
  flex: "1",
  ":first-child": {
    marginRight: "2rem",
  },
});
const TextAreaContainer = styled("div", {
  margin: "1rem 0 1.5rem",
});
const Hidden = styled("div", { display: "none" });
const SentAlert = styled("header", {
  marginBottom: "1.5rem",
  display: "flex",
  alignItems: "center",
  color: "#A7F3D0",
  border: "1px solid #A7F3D0",
  borderRadius: "4px",
  padding: "1rem",
});

function Contact() {
  const isSent = typeof window !== "undefined" && /sent=true/.test(window.location.search);
  return (
    <Page title="Contact">
      <Helmet>
        <title>Contact | Grace Kim-Butler</title>
      </Helmet>
      <form action="https://app.99inbound.com/api/e/ExU0a1d5" method="POST">
        {isSent && <SentAlert>Thank you! I will get back to you as soon as I can.</SentAlert>}
        <Fields>
          <Field>
            <FieldLabel htmlFor="contactName">Name</FieldLabel>
            <Input type="text" id="contactName" name="name" autoComplete="name" />
          </Field>
          <Field>
            <FieldLabel htmlFor="contactEmail">Email</FieldLabel>
            <Input type="email" id="contactEmail" name="email" autoComplete="email" />
          </Field>
        </Fields>
        <TextAreaContainer>
          <FieldLabel htmlFor="contactMessage">Message</FieldLabel>
          <TextArea name="message" id="contactMessage" rows="4" />
        </TextAreaContainer>
        <Hidden>
          <input
            type="checkbox"
            name="groovy_tan_glossy_deer_mouse"
            value="1"
            tabIndex="-1"
            autoComplete="no"
          />
        </Hidden>
        <FormButton type="submit">Send</FormButton>
      </form>
    </Page>
  );
}

export default () => (
  <Layout>
    <Contact />
  </Layout>
);
