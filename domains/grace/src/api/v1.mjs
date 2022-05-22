function getAllowedHeaders(request) {
  return {
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
    "Access-Control-Allow-Origin":
      request.headers.get("Origin") === "http://localhost:3000"
        ? "http://localhost:3000"
        : "https://grace.kimbutler.xyz",
    "Access-Control-Allow-Headers": "*",
    Vary: "Origin",
  };
}

function errorBoundary(responsePromise) {
  return responsePromise.catch((error) => {
    console.error(error.message);
    return new Response("Something went wrong", { status: 500 });
  });
}

async function sendEmail({ name, email, message }) {
  const request = new Request("https://api.mailchannels.net/tx/v1/send", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      personalizations: [{ to: [{ email: "grace@kimbutler.xyz", name: "Grace Kim-Butler" }] }],
      from: { email, name },
      subject: "Message from Personal Website Contact",
      content: [{ type: "text/plain", value: message }],
    }),
  });
  const resp = await fetch(request);
  if (!resp.ok) {
    throw new Error(await resp.json());
  }
}

async function handleContactAPI(request) {
  const data = await request.formData();
  await sendEmail({
    name: data.get("name"),
    email: data.get("email"),
    message: data.get("message"),
  });

  const isFetchRequest = request.headers.get("X-Requested-With") === "fetch";
  return new Response(null, {
    status: isFetchRequest ? 200 : 302,
    headers: isFetchRequest ? getAllowedHeaders(request) : { Location: "/contact/" },
  });
}

async function handleRequest(request) {
  const { method, url } = request;
  if (method === "OPTIONS") {
    return new Response(null, { status: 200, headers: getAllowedHeaders(request) });
  } else if (method === "POST" && new URL(url).pathname === "/api/v1/contact") {
    return handleContactAPI(request);
  }
  return new Response(null, { status: 404 });
}

addEventListener("fetch", (event) => {
  event.respondWith(errorBoundary(handleRequest(event.request)));
});
