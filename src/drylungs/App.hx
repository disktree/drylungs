package drylungs;

class App {

	public static var isMobile(default,null) = om.System.isMobile();

	static var header : Element;
	static var nav : Element;
	static var social : Element;
	static var content : Element;
	static var footer : Element;

	static inline function updateMetaElements() {
		updateFooterElement();
		updateSocialElement();
	}

	static function updateSocialElement() {
		if( window.innerHeight >= document.documentElement.scrollHeight ) {
			//nav.classList.remove( 'hidden' );
			social.classList.remove( 'hidden' );
		} else {
			var v = header.offsetTop + header.clientHeight - 100;
			if( window.scrollY > v ) {
				//nav.classList.add( 'hidden' );
				social.classList.add( 'hidden' );
			} else {
				//nav.classList.remove( 'hidden' );
				social.classList.remove( 'hidden' );
			}
		}
	}

	static function updateFooterElement() {
		if( window.innerHeight >= document.documentElement.scrollHeight ) {
			footer.classList.remove( 'hidden' );
		} else {
			var offset = 4;
			if( document.documentElement.scrollTop + footer.clientHeight >= document.documentElement.scrollHeight - window.innerHeight - offset ) {
				footer.classList.remove( 'hidden' );
			} else {
				footer.classList.add( 'hidden' );
			}
		}
	}

	static function init() {

		if( isMobile) {
			//window.alert( 'Mobile stylesheet is gay' );
		}

		//trace(document.baseURI);
		//trace(document.querySelectorAll('li.record'));
		//trace(window.innerHeight);

		header = document.querySelector( 'header' );
		nav = document.querySelector( 'nav' );
		content = document.querySelector( 'main' );
		social = document.querySelector( 'section.social' );
		footer = document.querySelector( 'footer' );

		updateMetaElements();

		window.onscroll = function(e){
			updateMetaElements();
		}
		window.onresize = function(e){
			updateMetaElements();
		}

		var pathname = window.location.pathname;
		switch pathname {
		case '/','/records':
			var records = document.querySelectorAll( 'li.record' );
			var selectedRecord : Element = null;
			for( rec in records ) {
				var el = cast( rec, Element );
				el.onclick = function(e){
					//var rect = el.getBoundingClientRect();
					//trace(el.querySelector('.details') );


					//var details = el.querySelector('.details');
					//details.style.display = 'block';

					if( selectedRecord != null ) {
						selectedRecord.classList.remove( 'selected' );
					}

					selectedRecord = el;
					selectedRecord.classList.add( 'selected' );
					selectedRecord.scrollIntoView( { behavior: "smooth", block: "start" } );

					//window.scrollTo( 100, 0 );
				}

			}
		}

		/*
		document.fonts.ready.then( function(_){
		//trace("Fonts loaded");
		//document.querySelector('header').style.visibility = 'visible';
	});
	*/

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

		console.info( '%c' + 'DRYLUNGS.AT', 'color:#5e6461' );
		console.info( '%c' + '${Drylungs.BUILDINFO}', 'color:#5e6461' );

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
