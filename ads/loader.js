(async function () {
    const currentScript = document.currentScript;

    const target =
        currentScript.previousElementSibling?.classList.contains("weekmotion-ad")
            ? currentScript.previousElementSibling
            : document.querySelector(".weekmotion-ad");

    if (!target) return;

    const html = await fetch(
        "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.html?t=" +
            Date.now()
    ).then(r => r.text());

    target.innerHTML = html;
})();
