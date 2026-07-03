(async () => {
    const target = document.currentScript.previousElementSibling;

    if (!target) return;

    const shadow = target.attachShadow({ mode: "open" });

    const html = await fetch(
        "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.html?"+Date.now()
    ).then(r => r.text());

    shadow.innerHTML = html;
})();
