'use strict'

let menu, nav, main;

function toggleNav() {
    menu.classList.toggle('is-active');
    nav.classList.toggle('show');
    main.classList.toggle('blur');
}

window.addEventListener('load', _ => {

    console.info('%c⛧ DRYLUNGS RECORDS ⛧', 'background:#000;color:#fff;padding:4px;font-size:23px;');

    const header = document.body.querySelector('header');
    const title = header.querySelector('.title');
	const page = header.querySelector('.page');
    nav = document.body.querySelector('nav');
    main = document.body.querySelector('main');
    menu = header.querySelector('.menu');

    menu.onclick = _ => {
        toggleNav();
    };
    title.onclick = _ => {
        toggleNav();
    };
    page.onclick = _ => {
        toggleNav();
    };
    main.onclick = _ => {
        if (main.classList.contains('blur')) {
            toggleNav();
        }
    };

    window.addEventListener('keydown', e => {
        if (e.keyCode === 27) {
            toggleNav();
        }
    }, false);
}, false);
