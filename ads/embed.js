(async function () {

    const css = document.createElement("link");
    css.rel = "stylesheet";
    css.href = "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.css";
    document.head.appendChild(css);

    const html = await fetch(
        "https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.html"
    ).then(r => r.text());

    document.querySelectorAll("weekmotion-banner").forEach(el=>{
        el.innerHTML = html;
    });

})();
