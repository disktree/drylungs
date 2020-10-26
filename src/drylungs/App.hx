package drylungs;

import js.html.File;
import om.Browser;
import om.Theme;

class App {

	static var storage = Browser.localStorage;

	static var headerElement : Element;
	static var menuElement : Element;
	static var navElement : Element;
	static var mainElement : Element;

	@:expose("theme")
	static var theme : om.Theme.Data = {
		background : "#101111",
		f_high : "#919794",
		f_med : "#5e6461",
		f_low : "#2d2f2e",
		f_inv : "#fff",
		b_high : "#292b2b",
		b_med : "#101010",
		b_low : "#010101",
		b_inv : "#101111"
	}

	@:expose("loadThemeSVG")
	public static function loadTheme( svg : String, store = false ) {
		var theme = Theme.parseSVG( svg );
		applyTheme( theme );
		if( store ) storage.setItem( 'drylungs_theme', Json.stringify( theme ) );
	}

	static function applyTheme( theme : om.Theme.Data ) {
		App.theme = theme;
		Theme.apply( theme );
		document.head.querySelector( 'meta[name="theme-color"]' ).setAttribute("content",theme.background);
	}

	static function toggleNav() {
		menuElement.classList.toggle( 'is-active' );
		navElement.classList.toggle( 'show' );
		mainElement.classList.toggle( 'blur' );
	}

	static function main() {

		console.info( '%c⛧ DRY LUNGS RECORDS ⛧', 'background:#000;color:#fff;padding:4px;' );

		var _cache = storage.getItem( 'drylungs_theme' );
		if( _cache != null ) {
			var theme = Json.parse( _cache );
			applyTheme( theme );
		} else {
			applyTheme( App.theme );
			//TODO set meta[name="theme-color"] from value in theme css
		}
			
		window.addEventListener( 'load', e -> {
			
			var body = document.body;
			
			headerElement = document.querySelector('header');
			//headerElement.onclick = e -> toggleNav();
			
			menuElement = headerElement.querySelector( '.menu' );
			
			navElement = document.querySelector('nav');
			
			mainElement = document.querySelector('main');

			menuElement.onclick = e -> toggleNav();

			var pageElement = headerElement.querySelector('.page');
			pageElement.onclick = e -> toggleNav();

			var dropElement = document.body;
			dropElement.addEventListener( 'dragover', e -> {
				e.stopPropagation();
				e.preventDefault();
				e.dataTransfer.dropEffect = 'copy';
				dropElement.classList.add( 'file-dragover' );
			}, false );
			dropElement.addEventListener( 'drop', e -> {
				e.stopPropagation();
				e.preventDefault();
				dropElement.classList.remove( 'file-dragover' );
				var file : File = e.dataTransfer.files[0];
				switch file.type {
				case "image/svg+xml":
					dropElement.classList.add( 'file-drop' );
					var reader = new js.html.FileReader();
					reader.onload = e -> {
						dropElement.classList.remove( 'file-drop' );
						trace(e.target.result );
						loadTheme( e.target.result, true );
					};
					reader.readAsText( file, 'UTF-8' );
				default:
					Browser.alert( 'SVG files only' );
				}
			}, false );
		
			/* document.body.onclick = e -> Browser.openFile( files -> {
				trace(files);
				var reader = new js.html.FileReader();
				reader.onload = e -> {
				  trace(e.target.result);
				  theme.load( om.Theme.parseSVG( e.target.result) );
				};
				reader.readAsText(files[0], 'UTF-8');
			}, 'image/svg+xml' );
			*/
			 
			/* window.addEventListener( 'scroll', e -> {
				menuElement.classList.remove( 'is-active' );
				navElement.classList.remove( 'show' );
				mainElement.classList.remove( 'blur' );
			}, false ); */
			
			var links : Array<AnchorElement> = cast document.getElementsByTagName( 'a' );
			for( e in links ) {
				e.onclick = function(){
					switch e.target {
					case null,'','_self':
						/*
						document.body.animate([
							{ opacity: '1' },
							{ opacity: '0' }
						], { duration: 33 } ).onfinish = function(_){
							document.body.style.opacity = '0';
							window.location.href = e.href;
						};
						*/
						//document.body.style.opacity = '0';
						document.body.style.pointerEvents = 'none';
						//document.body.style.background = 'red';
						//document.body.classList.add("loading");
						window.location.href = e.href;
						return false;
					default:
						return true;
					}
				}
			}
			
			body.classList.add( 'ready' );
		});

		if( navigator.serviceWorker != null ) {
			navigator.serviceWorker.register('sw.js').then(function(reg) {
				console.log( 'service worker registration succeeded. scope: ' + reg.scope );
			});
		}
	}
}
