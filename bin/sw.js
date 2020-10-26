const CACHE_NAME = "drylungs-cache-1";
const urlsToCache = [
	"./css/app.css",
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
