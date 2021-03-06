const React = require("react");

function getFathomScriptTags() {
  return [
    <script
      key="fathom-remote-js"
      type="text/javascript"
      src="https://toucan.kimbutler.xyz/script.js"
      spa="auto"
      data-site="SULYZTWP"
      defer
    />,
  ];
}

exports.onRenderBody = ({ setPostBodyComponents }) => {
  if (process.env.NODE_ENV === "production") {
    return setPostBodyComponents(getFathomScriptTags());
  }
  return null;
};
