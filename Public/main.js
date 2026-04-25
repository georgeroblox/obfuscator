async function run() {
  const code = document.getElementById("input").value;
  const status = document.getElementById("status");
  status.textContent = "Processing...";

  const res = await fetch(
    "https://api.github.com/repos/YOURNAME/YOURREPO/actions/workflows/obfuscate.yml/dispatches",
    {
      method: "POST",
      headers: {
        "Accept": "application/vnd.github+json",
        "Authorization": "Bearer YOUR_GITHUB_TOKEN"
      },
      body: JSON.stringify({
        ref: "main",
        inputs: { code }
      })
    }
  );

  if (!res.ok) {
    status.textContent = "Error running obfuscator";
    return;
  }

  status.textContent = "Obfuscation started. Check Actions tab.";
}
