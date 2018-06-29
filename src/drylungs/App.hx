package drylungs;

class App {

	public static var isMobile(default,null) = om.System.isMobile();

	static var header : Element;
	static var social : Element;
	static var content : Element;
	static var footer : Element;

	static inline function updateMetaElements() {
		updateFooterElement();
		updateSocialElement();
	}

	static function updateSocialElement() {
		if( window.innerHeight >= document.documentElement.scrollHeight ) {
			social.classList.remove( 'hidden' );
		} else {
			var v = header.offsetTop + header.clientHeight - 100;
			if( window.scrollY > v ) {
				social.classList.add( 'hidden' );
			} else {
				social.classList.remove( 'hidden' );
			}
		}
	}

	static function updateFooterElement() {
		if( window.innerHeight >= document.documentElement.scrollHeight ) {
			footer.classList.remove( 'hidden' );
		} else {
			if( document.documentElement.scrollTop + footer.clientHeight >= document.documentElement.scrollHeight - window.innerHeight  ) {
				footer.classList.remove( 'hidden' );
			} else {
				footer.classList.add( 'hidden' );
			}
		}
	}

	static function init() {

		if( isMobile) {
			window.alert( 'Mobile stylesheet is gay' );
		}

		header = document.querySelector( 'header' );
		content = document.querySelector( 'main' );
		social = document.querySelector( 'section.social' );
		footer = document.querySelector( 'footer' );

		updateMetaElements();

		/*
		document.fonts.ready.then( function(_){
			//trace("Fonts loaded");
			//document.querySelector('header').style.visibility = 'visible';
		});
		*/

		window.onscroll = function(e){
			updateMetaElements();
		}

		window.onresize = function(e){
			updateMetaElements();
		}

		/*
		window.onbeforeunload = function(e){
			document.body.style.background = '#000';
			//	document.body.style.display = 'none';
			return null;
		}
		*/

		/*
		var links = document.querySelectorAll('a');
		var overlay = document.getElementById('overlay');
		for( a in links ) {
			a.addEventListener( 'click', function(e){
				e.preventDefault();
				overlay.style.display = 'block';
				overlay.animate( [
					{ opacity: '1' },
					{ opacity: '0' }

				], { duration: 1000 } ).onfinish = e -> {
					window.open( cast (a,AnchorElement).href, '_self' );
				};
			} );
		}
		*/
	}

	static function main() {

		console.info( '%c' + 'DRYLUNGS.AT - R${Drylungs.REVISION} - ${Drylungs.VERSION}', 'color:#5e6461' );
		console.debug( '%c' + Drylungs, 'color:#5e6461' );

		document.addEventListener( 'readystatechange', function(e){
			switch document.readyState {
			case 'interactive':
				//
			case 'complete':
				init();
			}
		});
	}

}
