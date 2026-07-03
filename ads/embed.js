(async function () {

    // CSS Load
    if (!document.getElementById("wm-banner-css")) {
        const css = document.createElement("link");
        css.id = "wm-banner-css";
        css.rel = "stylesheet";
        css.href = "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.css";
        document.head.appendChild(css);
    }

    // HTML Load
    const html = await fetch(
        "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.html?v=" + Date.now()
    ).then(r => r.text());
    
    document.currentScript.insertAdjacentHTML("beforebegin", html);

})();
