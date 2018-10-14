package drylungs;

#if js

import haxe.Timer;

class App {

	//static var isMobile = om.System.isMobile();

	static var header : Element;
	static var title : Element;
	static var btn : Element;
	static var nav : Element;
	static var main_ : Element;
	static var social : Element;
	static var footer : Element;

	/*
	static function showNav() {
		//btn.classList.add( 'show' );
		//nav.classList.add( 'show' );
	}

	static function hideNav() {
		//btn.classList.remove( 'show' );
		//nav.classList.remove( 'show' );
	}
	*/

	static function hideNav() {
		//btn.classList.add( 'hidde' );
//		btn.classList.remove( 'active' );
		btn.classList.remove( 'is-active' );
		nav.classList.add( 'hidden' );
		main_.classList.remove( 'blur' );
	}

	static function toggleNav() {
		//btn.classList.toggle( 'show' );
		//nav.classList.toggle( 'show' );
//		btn.classList.toggle( 'active' );
		btn.classList.toggle( 'is-active' );
		nav.classList.toggle( 'hidden' );
		main_.classList.toggle( 'blur' );
	}

	static function handleWindowScroll(e) {
		hideNav();
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
				btn = header.querySelector( 'button' );
				nav = document.body.querySelector( 'nav' );
				main_ = document.body.querySelector( 'main' );

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

				//header.classList.add('hidden');
				nav.classList.add('hidden');

				window.addEventListener( 'scroll', handleWindowScroll, false );

				switch page {
				case 'start':
					//var ani = new drylungs.app.StartAnimation();
					//ani.start();
				case 'record':
					window.onkeydown = function(e){
						/*
						trace(e.keyCode);
						switch e.keyCode {
						case 87:
						}
						*/
					}
				}

				//TODO
				/*
				var links : Array<AnchorElement> = cast document.getElementsByTagName( 'a' );
				for( e in links ) {
					if( e.href == null ) continue;
					e.onclick = function(){
						switch e.target {
						case null,'','_self':
							document.body.animate([
								{ opacity: '1' },
								{ opacity: '0' }
							], { duration: 33 } ).onfinish = function(_){
								document.body.style.opacity = '0';
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
