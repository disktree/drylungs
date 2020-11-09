'use strict'

const STORAGE_ID = 'drylungs_theme';
let style;

function loadTheme() {
	var _theme = window.localStorage.getItem(STORAGE_ID);
	if(!_theme)
		return null;
	return JSON.parse(_theme);
}

function saveTheme(theme) {
	window.localStorage.setItem(STORAGE_ID,JSON.stringify(theme));
}

function readSVG(file, callback) {
    const reader = new FileReader()
    reader.onload = (e) => {
      callback(e.target.result);
    }
    reader.readAsText(file,'UTF-8');
}

function applyTheme(theme,save) {
	var s = document.documentElement.style;
	s.setProperty("--background",theme.background);
	s.setProperty("--f_high",theme.f_high);
	s.setProperty("--f_med",theme.f_med);
	s.setProperty("--f_low",theme.f_low);
	s.setProperty("--f_inv",theme.f_inv);
	s.setProperty("--b_high",theme.b_high);
	s.setProperty("--b_med",theme.b_med);
	s.setProperty("--b_low",theme.b_low);
	s.setProperty("--b_inv",theme.b_inv);
	if(save) saveTheme(theme);
}

document.addEventListener('DOMContentLoaded', event => {
	style = window.getComputedStyle(document.querySelector(':root'));
	if( style ) {
		var theme = loadTheme();
		if( theme ) {
			applyTheme( theme );
		} else {
			theme = {
				background: style.getPropertyValue('--background'),
				f_high: style.getPropertyValue('--f_high'),
				f_med: style.getPropertyValue('--f_med'),
				f_low: style.getPropertyValue('--f_low'),
				f_inv: style.getPropertyValue('--f_inv'),
				b_high: style.getPropertyValue('--b_high'),
				b_med: style.getPropertyValue('--b_med'),
				b_low: style.getPropertyValue('--b_low'),
				b_inv: style.getPropertyValue('--b_inv'),
			};
			saveTheme(theme);
		}
	}
	if(document.body)
		document.body.style.visibility = "visible";

	window.addEventListener('dragover', e => {
		e.stopPropagation()
		e.preventDefault()
		e.dataTransfer.dropEffect = 'copy'
	});

	window.addEventListener('drop', e => {
		e.preventDefault();
		const file = e.dataTransfer.files[0];
		if(file && file.name.indexOf('.svg') > -1) {
			this.readSVG(file, (data) => {
				const svg = new DOMParser().parseFromString(data, 'text/xml');
				var theme = {
					background: svg.getElementById('background').getAttribute('fill'),
					f_high: svg.getElementById('f_high').getAttribute('fill'),
					f_med: svg.getElementById('f_med').getAttribute('fill'),
					f_low: svg.getElementById('f_low').getAttribute('fill'),
					f_inv: svg.getElementById('f_inv').getAttribute('fill'),
					b_high: svg.getElementById('b_high').getAttribute('fill'),
					b_med: svg.getElementById('b_med').getAttribute('fill'),
					b_low: svg.getElementById('b_low').getAttribute('fill'),
					b_inv: svg.getElementById('b_inv').getAttribute('fill')
				}
				applyTheme(theme);
				saveTheme(theme);
			});
		}
		e.stopPropagation();
	});
});

