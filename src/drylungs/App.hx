package drylungs;

import js.html.File;
import js.html.Storage;
import om.Browser;
import om.Theme;

class App {

	static var headerElement : Element;
	static var menuElement : Element;
	static var navElement : Element;
	static var mainElement : Element;

	static var storage = Browser.localStorage;

	@:expose("loadThemeSVG")
	public static function loadTheme( svg : String, store = false ) {
		var theme = Theme.parseSVG( svg );
		applyTheme( theme );
		if( store ) storage.setItem( 'drylungs_theme', Json.stringify( theme ) );
	}

	static function applyTheme( theme : om.Theme.Data ) {
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

			//theme.install();
			
			var _cache = storage.getItem( 'drylungs_theme' );
			if( _cache != null ) {
				var theme = Json.parse( _cache );
				applyTheme( theme );
			} else {
				//TODO set meta[name="theme-color"] from value in theme css
			}

			/*
			var dropElement = document.body;
			dropElement.addEventListener( 'dragstart', e -> {
				e.stopPropagation();
				e.preventDefault();
			});
			dropElement.addEventListener( 'dragover', e -> {
				e.stopPropagation();
				e.preventDefault();
				trace(e);
				e.dataTransfer.dropEffect = 'copy';
				dropElement.classList.add( 'file-dragover' );
			}, false );
			dropElement.addEventListener( 'dragenter', e -> {
				e.stopPropagation();
				e.preventDefault();
				dropElement.classList.add( 'file-dragover' );
			});
			dropElement.addEventListener( 'dragstart', e -> {
				e.stopPropagation();
				e.preventDefault();
			});
			dropElement.addEventListener( 'dragleave', e -> {
				e.stopPropagation();
				e.preventDefault();
				dropElement.classList.remove( 'file-dragover' );
			}, false );
			dropElement.addEventListener( 'dragend', e -> {
				e.stopPropagation();
				e.preventDefault();
				dropElement.classList.remove( 'file-dragover' );
			}, false );
			dropElement.addEventListener( 'drop', e -> {
				e.stopPropagation();
				e.preventDefault();
				dropElement.classList.remove( 'file-dragover' );
				var file : File = e.dataTransfer.files[0];
				trace(file);
				switch file.type {
				case "image/svg+xml":
					dropElement.classList.add( 'file-drop' );
					var reader = new js.html.FileReader();
					reader.onload = e -> {
						dropElement.classList.remove( 'file-drop' );
						theme.set( om.Theme.parseSVG( e.target.result) );
						storage.setItem( 'theme', Json.stringify( theme.data ) );
					};
					reader.readAsText( file, 'UTF-8' );
				default:
					Browser.alert( 'SVG files only' );
				}
			}, false );
			*/
		
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
						document.body.style.opacity = '0';
						window.location.href = e.href;
						return false;
					default:
						return true;
					}
				}
			}
			
			body.classList.add( 'ready' );
		});
	}
}
