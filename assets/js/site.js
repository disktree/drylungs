'use strict'

const isMobileDevice = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent);
//const prefersReducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)");

let menu, nav, main;

function toggleNav() {
    if (isMobileDevice) {
        menu.classList.toggle('is-active');
        nav.classList.toggle('show');
        main.classList.toggle('blur')
    } else {
        location.href = "/";
    }
}

window.addEventListener('load', _ => {

    console.info('%c⛧  DRYLUNGS RECORDS ⛧', 'background:#000;color:#fff;padding:4px;font-size:23px;');

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
        if (e.code === 'Escape') {
            toggleNav();
        }
    }, false);
}, false);
