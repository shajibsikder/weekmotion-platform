fetch("https://cdn.jsdelivr.net/gh/shajibsikder/weekmotion-platform@main/ads/banner.html")
.then(r => r.text())
.then(html => {
    document.querySelector(".weekmotion-ad").innerHTML = html;
})
.catch(err => console.log(err));
