package drylungs;

#if !macro @:build(drylungs.macro.BuildApp.build()) #end
class App {

	static var isMobile : Bool;

	static function init() {

		if( isMobile) {
			window.alert( 'Mobile stylesheet is gay' );
		}

		var body = document.body;
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
		document.addEventListener( 'readystatechange', function(e){
			switch document.readyState {
			case 'interactive':
				//
			case 'complete':
				console.info( 'DRYLUNGS.AT' );
				isMobile = om.System.isMobile();

				init();
			}
		});

		/*
		window.onload = function() {

			trace("LOADED");

			console.info( 'DRYLUNGS.AT' );
			console.info( om.System.isMobile() );

			if( om.System.isMobile() ) {
				window.alert( 'Mobile stylesheet is gay' );
			}

			window.onbeforeunload = function(e){
				document.body.style.background = '#000';
			//	document.body.style.display = 'none';
				return null;
			}
			*/

			/*
			document.fonts.ready.then( function(_){
				trace("Fonts loaded");
				document.body.style.display = 'block';
			});
			*/

			/*
			window.onscroll = function(e){
				var scrollPos = window.innerHeight+window.scrollY;
				if( scrollPos >= document.body.scrollHeight ) {
					document.querySelector( 'footer' ).classList.remove('hidden');
				} else {
					document.querySelector( 'footer' ).classList.add('hidden');
				}
				//trace(window.innerHeight+window.scrollY, document.body.scrollHeight);
			}

		}
		*/
	}

}
