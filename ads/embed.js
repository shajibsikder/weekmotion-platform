(async () => {

    // CSS
    const css = document.createElement("link");
    css.rel = "stylesheet";
    css.href = "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.css";
    document.head.appendChild(css);

    // HTML
    const html = await fetch(
        "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.html"
    ).then(r => r.text());

    const div = document.createElement("div");
    div.innerHTML = html;

    document.body.prepend(div);

})();
