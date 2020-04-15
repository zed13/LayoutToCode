'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "4f563b98755c30947c9b1bb84b483429",
"assets/LICENSE": "cf91ea6a911171ac55d1ed76aeea924d",
"assets/assets/ic_java_48.png": "663413e8bd84a9d0e68f71efa5a603bb",
"assets/assets/ic_kotlin_48.png": "a9fba9d20e168c72bf204d179f16a915",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"main.dart.js": "1ab85644e3f0386a5812ee5e7d78d018",
"index.html": "008330ab9961237efef105fbf4a8eb3a",
"/": "008330ab9961237efef105fbf4a8eb3a"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
