(async function () {
    try {

        // CSS
        if (!document.getElementById("wm-banner-css")) {
            const css = document.createElement("link");
            css.id = "wm-banner-css";
            css.rel = "stylesheet";
            css.href = "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.css";
            document.head.appendChild(css);
        }

        // HTML
        const html = await fetch(
            "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.html"
        ).then(r => r.text());

        // Placeholder এ Insert
        const container = document.getElementById("weekmotion-banner");

        if (container) {
            container.innerHTML = html;
        }

    } catch (e) {
        console.error(e);
    }
})();
