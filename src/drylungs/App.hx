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

	static function hideNav() {
		btn.classList.remove( 'is-active' );
		nav.classList.add( 'hidden' );
		main_.classList.remove( 'blur' );
	}

	static function toggleNav() {
		btn.classList.toggle( 'is-active' );
		nav.classList.toggle( 'hidden' );
		main_.classList.toggle( 'blur' );
	}

	static function handleWindowScroll(e) {
		hideNav();
	}

	static function main() {

		console.info( '%c⛧ DRYLUNGS ⛧', 'color:#ff0000;font-size:100px;' );

		document.addEventListener( 'readystatechange', function(e){

			switch document.readyState {
			case 'interactive':
			case 'complete':

				var body = document.body;

				//trace(om.System.supportsTouchInput());

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

				//btn.onclick = function(){
				header.onclick = function(){
					toggleNav();
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
					var ani = new drylungs.app.StartAnimation();
					//ani.start();
				case 'record':
					window.onkeydown = function(e){
						//trace(e.keyCode);
						switch e.keyCode {
						case 37: // left
							var link = main_.querySelector('.nav a.prev').getAttribute('href');
							window.location.href = link;
						case 39: // right
							var link = main_.querySelector('.nav a.next').getAttribute('href');
							window.location.href = link;
						}
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
