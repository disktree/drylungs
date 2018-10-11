package drylungs;

#if js

import haxe.Timer;

class App {

	//static var isMobile = om.System.isMobile();

	static var header : Element;
	static var title : Element;
	static var btn : Element;
	static var nav : Element;
	static var social : Element;
	static var footer : Element;

	static function openNav() {
		btn.classList.add( 'show' );
		nav.classList.add( 'show' );
	}

	static function closeNav() {
		btn.classList.remove( 'show' );
		nav.classList.remove( 'show' );
	}

	static function toggleNav() {
		btn.classList.toggle( 'show' );
		nav.classList.toggle( 'show' );
	}

	static function handleWindowScroll(e) {
		closeNav();
	}

	static function main() {

		console.info( '%c⛧ DRYLUNGS ⛧', 'color:#101111' );

		document.addEventListener( 'readystatechange', function(e){

			switch document.readyState {
			case 'interactive':
			case 'complete':

				var page = document.body.getAttribute('data-id');

				/*
				var path = window.location.pathname;
				var site : String = untyped SITE;
				path = path.substr( path.indexOf( site ) );
				*/

				header = document.body.querySelector( 'header' );
				nav = document.body.querySelector( 'nav' );
				btn = header.querySelector( 'button' );

				btn.onclick = function(){
					toggleNav();
					//btn.classList.toggle( 'show' );
					//nav.classList.toggle( 'show' );
				}

				/*
				nav.onclick = function(){
					//toggleNav();
				}
				*/

				window.addEventListener( 'scroll', handleWindowScroll, false );

				switch page {
				case 'record':
					window.onkeydown = function(e){
						/*
						switch e.keyCode {
						case 87:
						}
						*/
					}
				}

				/*
				//TODO
				var links : Array<AnchorElement> = cast document.getElementsByTagName( 'a' );
				for( e in links ) {
					if( e.href == null ) continue;
					e.onclick = function(){
						switch e.target {
						case null,'','_self':
							document.body.animate([
								{ opacity: '1' },
								{ opacity: '0' }
							], { duration: 1000 } ).onfinish = function(_){
								window.location.href = e.href;
							};
							return false;
						default:
							return true;
						}
					}
				}
				*/
			}
		});
	}
	
}

#end
