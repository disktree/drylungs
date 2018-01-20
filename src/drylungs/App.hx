package drylungs;

class App {

    static inline var ROOT = '/project/drylungs.at/bin/';

    static var focusedRelease : Element;

    static function focusRelease( id : String ) {

        if( focusedRelease != null ) {
            focusedRelease.classList.remove( 'focused' );
        }

        var e = document.querySelector( 'li.release[data-id="$id"]' );
        //trace(e);

        focusedRelease = e;
        focusedRelease.classList.add( 'focused' );

        var py = DOM.y( focusedRelease );

        //document.documentElement.scrollTop = Std.int( py );

        /*
        var tween = new Tween( { v: 0 } );
        tween.to( { v: py }, 1000 )
            //.easing( Linear.None )
            .onUpdate( function(){
                trace(tween.value);
                //document.documentElement.scrollTop = Std.int( tween.value );
            })
            .start();
            */


        //focusedRelease.animate();
        //document.body.scrollTop = Std.int(v);

        /*
        console.debug(DOM.y(focusedRelease));
        focusedRelease.scrollIntoView();
        console.debug(DOM.y(focusedRelease));
        */

    }

    static function handleAnimationFrame( time : Float ) {
        window.requestAnimationFrame( handleAnimationFrame );
        om.Tween.step( time );
    }

    static function handleWindowResize(e) {
    }

    static function handleWindowScroll(e) {

        var scrollTop = document.documentElement.scrollTop;
        //trace(scrollTop);

        var releases = document.querySelector( 'ol.releases' );
        var opacity = 1.0;
        //trace(releases);
        for( e in releases.children ) {
            //var content = document.querySelector( '' );
            opacity = 1.0;
            var rect = e.getBoundingClientRect();
            if( rect.y < 0 ) {
                opacity = 1 - Math.abs( rect.y / 1000 );
                e.classList.add( 'past' );
            } else if( rect.y > window.innerHeight - rect.height ) {
                opacity = (window.innerHeight - rect.y) / 1000;
                e.classList.add( 'future' );
            } else {
                e.classList.remove( 'past', 'future' );
            }
            //e.style.opacity = Std.string( opacity );
            //e.style.transform = 'rotateX('+Std.int(rect.y/10)+'deg)';
        }

        /*
        for( e in releases.children ) {
            trace( document.documentElement.scrollTop );
            //var rect = e.getBoundingClientRect();
            //trace(rect.y);

            /*
            if( rect.y < 0 ) {
                e.classList.add( 'past' );
                        //e.style.background = '#00ff00';
                //var v = Math.abs( rect.y ) / 100 * Math.PI;
                //e.style.transform = 'rotateX('+Std.int(v)+'deg)';
            } else if( rect.y > window.innerHeight - 1000 ) {
                e.classList.add( 'future' );
            } else {
                e.classList.remove( 'past', 'future' );
                //e.style.background = '#ff00ff';
            }

            break;
        }
        */
    }

    static function handlePopState(e) {
        trace( e );
        window.alert("location: " + document.location + ", state: " + Json.stringify(e.state));
        //e.preventDefault();
    }

    static function getPath() : String {
        return window.location.pathname.substr( ROOT.length );
    }

    static function main() {

        console.info( 'DRYLUNGS' );

        window.onload = function() {

            document.body.style.display = 'block';

            var path = getPath();

            switch path {
            case '':
                /*
                for( e in document.querySelector( '.releases' ).children ) {
                    //trace(e);
                    e.onclick = function(){
                        var id = e.getAttribute( 'data-id' );
                        trace(id);
                        focusRelease( id );
                    }
                }
                */

            default:
            }

            /*
            om.FetchTools.fetchJson( 'releases.json' ).then( function(releases){
                trace( releases );
            });
            */

            var selectedElement : Element = null;
            for( e in document.querySelector( 'ol.releases' ).children ) {
                var id = e.getAttribute( 'data-id' );
                e.addEventListener( 'click', function(e){
                    e.preventDefault();
                    var el = document.querySelector( 'li.release[data-id=$id]' );
                    if( el == selectedElement ) {
                        el.classList.remove( 'selected' );
                        selectedElement = null;
                        return;
                    }
                    if( selectedElement != null ) {
                        selectedElement.classList.remove( 'selected' );
                    }
                    selectedElement = el;
                    //selectedElement.scrollIntoView();
                    selectedElement.classList.add( 'selected' );
                } );
            }

            window.addEventListener( 'resize', handleWindowResize, false );
            window.addEventListener( 'scroll', handleWindowScroll, false );
            //window.addEventListener( 'popstate', handlePopState, false );
            //window.onpopstate = handlePopState;

            window.ondragstart = function() { return false; }

            //history.pushState({page: 1}, "title 1", "?page=1");

            window.requestAnimationFrame( handleAnimationFrame );
        }
    }

}
