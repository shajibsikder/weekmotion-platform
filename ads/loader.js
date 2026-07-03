fetch("https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.html?" + Date.now())
.then(r=>r.text())
.then(html=>{
    document.querySelectorAll(".weekmotion-ad").forEach(el=>{
        el.innerHTML=html;
    });
});
