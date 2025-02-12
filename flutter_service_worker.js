'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "8c4ad9437a4f332ccaa070e4cd1dc5ce",
"index.html": "56f36c2ead1d9fdbb955d329c6bc0348",
"/": "56f36c2ead1d9fdbb955d329c6bc0348",
"version.json": "7af4e8cfb7cd22b96b1a6a0dac3902ad",
"icons/team_logo.png": "04e70cf7cdef71ee3138134781719395",
"favicon.png": "04e70cf7cdef71ee3138134781719395",
"assets/fonts/MaterialIcons-Regular.otf": "d16c215997f56212c70f3c68fdccc551",
"assets/AssetManifest.json": "eb167fb878c8eaa4841e65ac63d176d0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/images/team_logo.png": "04e70cf7cdef71ee3138134781719395",
"assets/AssetManifest.bin": "ec7981c3cb380d4e1c42b1d05a3476bc",
"assets/AssetManifest.bin.json": "421ab5e75c72635615f2bd9099ddccd8",
"assets/FontManifest.json": "2d2e46df0817fe19bff41df56c69b6da",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aab785ae479fbd3888b4e9ecac364693",
"assets/packages/geekyants_flutter_gauges/assets/fonts/Roboto-Regular.ttf": "8a36205bd9b83e03af0591a004bc97f4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b53590b0d9c36bf00ca4b4f2f832ef6d",
"assets/matches.json": "5b7f32bfaad25fe6a4a7a3c360334c76",
"assets/NOTICES": "9e55d6b5edf95f2fb3d3d87f6fa68144",
"main.dart.js": "6374474a6c842d88ecaf424ecf048df3",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
".git/HEAD": "978cf7ce582a3595b9d4daf7cc63115a",
".git/index": "18b8908a1537c4d025a57257210015fa",
".git/COMMIT_EDITMSG": "655d242e09a0059e6c1fb1b459626ad7",
".git/config": "5d607d5883a04c18200eeae0e6623caf",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/refs/remotes/origin/ghpages": "5c34b3d3d66a556ca41e8a5c7580494a",
".git/refs/heads/ghpages": "5c34b3d3d66a556ca41e8a5c7580494a",
".git/logs/HEAD": "546923c9024ca2a92f503ebd2f423b4b",
".git/logs/refs/remotes/origin/ghpages": "76cdd308baedb9c6b5a086a500bdcf8f",
".git/logs/refs/heads/ghpages": "067b61085b54bd867a47fce43f253345",
".git/objects/dd/f4bfacb396e97546364ccfeeb9c31dfaea4c25": "049d11285bcbd30a249b4dff756126a0",
".git/objects/dd/12a1b8d31402b9e3aaf69456ba93c40cf1a4ef": "4d2101377dc5c87cf6a2539de36b03b1",
".git/objects/73/7f149c855c9ccd61a5e24ce64783eaf921c709": "1d813736c393435d016c1bfc46a6a3a6",
".git/objects/ca/c72fbef63768311bb19d73afbb0c1ca0445e66": "269f7aaeb105c939ac58b8a3e73c8240",
".git/objects/2c/bede424b56795442b2e863eee8cd15a6ce8a3a": "9fe50edc10e9c28ef6874289d2259d80",
".git/objects/7d/110301d4f167bb0b01b9e13d79050363b08b63": "2c515ed341d21c2b3b63d17eea97497c",
".git/objects/f5/45bc1fbcea14ac9564d12e5482bbba67469d8d": "28ea7007a54a74ba3dae6cc41772d214",
".git/objects/4e/e967e599d5318a3f98bddbd9e98fbdcf9488e8": "bd7890bda7168ad7e4e9058edc09ad39",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/92/17413155c6d24e6a13ac13fa1f6493e09e0f49": "138cd3827980c6d455d1993f84462caa",
".git/objects/d2/b9542d134fc0328e131f225f2e3b855b27c62d": "ff0f559239c4a756dd1dd28673fb6cb7",
".git/objects/38/8cbd0fd20832c73ea010407488a9269a83b550": "a6960d2ec72a23b37461cb08b93875db",
".git/objects/79/552a5813eeacca483e92bf8fe5bdd71c015bde": "54a2a1f0ac9232232f4d56f8d7985028",
".git/objects/63/6931bcaa0ab4c3ff63c22d54be8c048340177b": "8cc9c6021cbd64a862e0e47758619fb7",
".git/objects/27/a297abdda86a3cbc2d04f0036af1e62ae008c7": "51d74211c02d96c368704b99da4022d5",
".git/objects/97/8a4d89de1d1e20408919ec3f54f9bba275d66f": "dbaa9c6711faa6123b43ef2573bc1457",
".git/objects/97/26da36fd245a2befde18461deb034db04b8b03": "b94f07b54aabc57f9c8608cf6bd49756",
".git/objects/42/98f36b45c4451c6f036e29ff1723cc1343365a": "4cb9ebec604d6fb1babf342e0b2edaf2",
".git/objects/05/a9058f513cce5faf1704e06e3c150688b0a01f": "e8d02f60cf87abd4c1de4b153dd696dc",
".git/objects/9a/3b4ca7a40100cd34a72fb70a10145553dd0b36": "b57d5045349176dc12d054851bb5e2d9",
".git/objects/9a/f9c8ae9ca056f4f0fcbda1a76472fb9f224684": "207850ebac0bba429e3bba845c63282f",
".git/objects/9a/14132358a0995692610da3c5b6fc414ab51b9a": "d0459d727cbd8bf1953b62dbd0931796",
".git/objects/2a/42705bd5b1dbd22d78ff8e14919561f511cf6b": "2efd2febeecc92549215a5ec1e14f155",
".git/objects/26/d9c2475a56db2008c71308fc7abcbb6122e1e2": "abc1bbafd1e788ef7c3fb51439a7225f",
".git/objects/64/058ce5b87f796f142fe2bfb5a3ca7fb33a2891": "af614940f9fbd68fe9b8621b7907e3e6",
".git/objects/a8/1c784f19aec73c000d243d9817bb858dec1d12": "6393b78c29fcdcf877380d376f399807",
".git/objects/ef/c9b73a8f5d2e523748b6d4b7ca505025fbdb07": "3b48dacf9b927d47b15801c5263f9c9b",
".git/objects/a0/88ea8f04efa3a9d8d0eb0ccf2460e1e1eae9f7": "02612ccbf3bd782cb9d4ca0fe59cc6d8",
".git/objects/5e/b9ba2438b8a68a6173dbafa24a09a1604679f4": "eea1226a1eea4ad99dac2059d6a15336",
".git/objects/c3/0bf37f6adda02b1ccfd0bfb9dc290aa0e76c5f": "4373db050111eda46b10a90a412f2088",
".git/objects/c3/e81f822689e3b8c05262eec63e4769e0dea74c": "8c6432dca0ea3fdc0d215dcc05d00a66",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "8f96f41fe1f2721c9e97d75caa004410",
".git/objects/b1/afd5429fbe3cc7a88b89f454006eb7b018849a": "e4c2e016668208ba57348269fcb46d7b",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/c7/fe50cffd0e578c99f227a9b33ac233410fddfc": "159b80aa550b4700898f0edb26e55787",
".git/objects/8c/59773bee8314a8ffb4431593d0fb49f52e34c6": "2eb993d30677573ffd0e58484cc6a514",
".git/objects/de/5341a41654b7043850a621b456f97ae4c2f7d3": "fabadea347580dbcbda5c6d59d8e23f9",
".git/objects/ec/361605e9e785c47c62dd46a67f9c352731226b": "d1eafaea77b21719d7c450bcf18236d6",
".git/objects/af/31ef4d98c006d9ada76f407195ad20570cc8e1": "a9d4d1360c77d67b4bb052383a3bdfd9",
".git/objects/44/9570b53cc64ff07650a8d45c4c4516c86287cc": "d51b2e8eb4c6708ed9d1c833b9629afa",
".git/objects/aa/ace59d73dfd89ca62911633da78f5d88d4c045": "19a3de06a681f694c8c76604c9a87eee",
".git/objects/c6/06caa16378473a4bb9e8807b6f43e69acf30ad": "ed187e1b169337b5fbbce611844136c6",
".git/objects/c2/5244911e6dbc3ba52f4bf546fdc0578ed2d8ce": "7a3de5fa40552a7f56c2f75e2fa5875c",
".git/objects/c2/b745cb28e9ccdf9905127a8cdba551bd48548f": "c5642a97ca4a75c6f0e482408bdcd132",
".git/objects/24/1ee447ab2fdb89248110c9ac2e21a0b106979e": "428f261c06f89da591f46e8d9d74ffca",
".git/objects/f9/4cdd1f596815f282a8e3cfca2ba6b266bc48d2": "346291bff7afce8efefb410bf96ed790",
".git/objects/6d/5f0fdc7ccbdf7d01fc607eb818f81a0165627e": "2b2403c52cb620129b4bbc62f12abd57",
".git/objects/b4/c7fd3981a28cccbab19b231bc9040302cb4198": "cac0907c651cba589ce084c28d1d4f4a",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
"manifest.json": "f22e80c2731f55c325cd24cad82ebbd4"};
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
