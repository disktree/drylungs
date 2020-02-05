const CACHE_NAME = "drylungs-cache-1";
const urlsToCache = [
	"./css/reset.css",
	"./css/app.css",
	"./fnt/helvetica_neue_65.woff2",
	"./fnt/icons.woff",
	"./ico/icon-48.png",
	"./img/cover/400/DLR001.webp",
	"./img/cover/400/DLR002.webp",
	"./img/cover/400/DLR003.webp",
	"./img/cover/400/MDMA001.webp",
	"./img/cover/400/MDMA002.webp",
	"./img/cover/400/MDMA003.webp",
	"./img/cover/400/MDMA004.webp",
	"./img/cover/400/MDMA005.webp",
	"./img/cover/400/MDMA006.webp",
	"./img/cover/400/MDMA007.webp",
	"./scr/app.js"
];

self.addEventListener("install", function(event) {
	console.log('install');
	event.waitUntil(
		caches.open(CACHE_NAME).then(function(cache) {
			console.log("Opened cache");
			return cache.addAll(urlsToCache);
		})
	);
});
	
self.addEventListener("fetch", function(event) {
	console.log('fetch',event);
	event.respondWith(
	  	caches.match(event.request).then(function(response) {
			if(response) {
				return response;
			}
			return fetch(event.request);
	  	})
	);
});
