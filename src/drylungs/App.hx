package drylungs;

#if !macro @:build(drylungs.macro.BuildApp.build()) #end
class App {

	static function main() {

		window.onload = function() {

			console.info( 'DRYLUNGS.AT' );

			document.fonts.ready.then( function(_){
				trace("Fonts loaded");
				document.body.style.display = 'block';
			});

			/*
			var links = document.querySelectorAll('a');
			for( link in links ) {
				//console.debug( link );
			}
			//trace(links);
			*/

			/*
			var records = document.querySelectorAll('drylungs-record');
			for( record in records ) {
				//console.debug( record );
				record.addEventListener('click', e -> {
					//trace( e.target );
					//e.target.classList.toggle('selected');
				} );
			}
			*/

			//window.onpopstate = function(e){

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
			*/

		}
	}

}
