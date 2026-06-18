'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "adba8ae65eef7fdf4d8ae844a38a49ce",
"assets/AssetManifest.bin.json": "1228be226bd2386776caf4d9c134d623",
"assets/assets/AssetManifest.bin": "adba8ae65eef7fdf4d8ae844a38a49ce",
"assets/assets/AssetManifest.bin.json": "1228be226bd2386776caf4d9c134d623",
"assets/assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/assets/NOTICES": "a2dc800aa7eea2679a2fa20d9b2dff4b",
"assets/assets/pixel_avatar_1.png": "28abbdabbd3e5b6769533af45e18db31",
"assets/assets/pixel_avatar_10.png": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/pixel_avatar_2.png": "9a405c88196d7c3fd8cf21afb9921d09",
"assets/assets/pixel_avatar_2_journal_1.png": "3ac28c11a8b523845da48c7abb86a64b",
"assets/assets/pixel_avatar_2_journal_2.png": "ce4410cf38fff3bc5aa3733233afdeac",
"assets/assets/pixel_avatar_2_journal_3.png": "19e55cd9fe476402f19ebf6c2e9bbdfb",
"assets/assets/pixel_avatar_2_lulus.png": "0747c824d68fea41574670cb25041f54",
"assets/assets/pixel_avatar_2_riset.png": "aebc914c40c7d0c8b726d004625cf19c",
"assets/assets/pixel_avatar_3.png": "8caa678fdf10dd2235583d82b42a63f2",
"assets/assets/pixel_avatar_4.png": "200483775d65db4f6a8061adaff4bbe9",
"assets/assets/pixel_avatar_5.png": "6529fcd1244b025a2be3a26b0bdfa2ad",
"assets/assets/pixel_avatar_6.png": "e752d6e13aae5c4ddaf89aa1ad30e5ff",
"assets/assets/pixel_avatar_7.png": "d8f92a2e69d781497cc8acd52b7c4c95",
"assets/assets/pixel_avatar_8.png": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/pixel_avatar_9.png": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/pixel_avatar_wanita_1.png": "15088ecc602601fa6fd7522deb0be061",
"assets/assets/pixel_avatar_wanita_10.png": "7d2ff39170b3474c06c0a35fd2222f83",
"assets/assets/pixel_avatar_wanita_2.png": "e8bb80fb4e64377082176c335e4eae6c",
"assets/assets/pixel_avatar_wanita_3.png": "06d0e4a3a85f5b514f01fc71df025080",
"assets/assets/pixel_avatar_wanita_4.png": "4e5be1a97ae8c3f0f022b3790e7b7924",
"assets/assets/pixel_avatar_wanita_5.png": "1c9cc19ca95f4a39b31aab8c32372f8f",
"assets/assets/pixel_avatar_wanita_6.png": "cd9820cc77b81e123768f6308309a28d",
"assets/assets/pixel_avatar_wanita_7.png": "8d9551c0f89246ff81c5f27c092f9fa1",
"assets/assets/pixel_avatar_wanita_8.png": "8a0d0a3bf4f639b4342434de486524f5",
"assets/assets/pixel_avatar_wanita_9.png": "01572b94fc1a731e9f3a0f3d7eb98959",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "b97ff3c7e70dc6468437d6a86a27a1cf",
"assets/NOTICES": "a2dc800aa7eea2679a2fa20d9b2dff4b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "fc7f29a3516b5c58bd84f87f82a5226e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "bf6a1d51d0b6e220f64c70db58e13033",
"/": "bf6a1d51d0b6e220f64c70db58e13033",
"main.dart.js": "215939ad003465217bb3b91d25e5894a",
"manifest.json": "43ca141d626b77dafb1603e5bad9ac47",
"version.json": "e6d415c1f78615d8c11d0a8d044bed8d"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
