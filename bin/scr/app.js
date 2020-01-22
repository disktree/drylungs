
console.info( '%c⛧ DRY LUNGS RECORDS ⛧', 'color:#000;' );

var headerElement;
var btnElement;
var navElement;
var mainElement;

function toggleNav() {
	btnElement.classList.toggle( 'is-active' );
	navElement.classList.toggle( 'hidden' );
	mainElement.classList.toggle( 'blur' );
}

window.addEventListener('DOMContentLoaded', e => {
	
	headerElement = document.querySelector('header');
	btnElement = headerElement.querySelector( 'button' );
	navElement = document.querySelector('nav');
	mainElement = document.querySelector('main');
	
	//nav.classList.add('hidden');
	
	headerElement.onclick = () => toggleNav();
	
	window.onkeydown = function(e){
		switch (e.keyCode) {
		case 37: // left
			var link = mainElement.querySelector('.nav a.prev').getAttribute('href');
			window.location.href = link;
		case 39: // right
			var link = mainElement.querySelector('.nav a.next').getAttribute('href');
			window.location.href = link;
		}
	}

	window.addEventListener( 'scroll', e => {
		btnElement.classList.remove( 'is-active' );
		navElement.classList.add( 'hidden' );
		mainElement.classList.remove( 'blur' );
	}, false );
});