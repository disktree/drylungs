'use strict'

console.info('%c⛧ DRYLUNGS RECORDS ⛧', 'background:#000;color:#fff;padding:4px;font-size:23px;');

let menu, nav, main;

function toggleNav() {
	menu.classList.toggle( 'is-active' );
    nav.classList.toggle( 'show' );
    main.classList.toggle( 'blur' );
}

window.addEventListener('load', e => {

    const header = document.body.querySelector('header');
    nav = document.body.querySelector('nav');
    main = document.body.querySelector('main');
    menu = header.querySelector('.menu');
	var page = header.querySelector('.page');
	
	menu.onclick = e => {
		return toggleNav();
	};
	page.onclick = e => {
		return toggleNav();
	};
});
