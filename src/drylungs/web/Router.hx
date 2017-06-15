package drylungs.web;

import drylungs.Web.context;
import haxe.web.Dispatch;

class Router {

    public function new() {}

    function doDefault( d : Dispatch ) {
        d.dispatch( new drylungs.web.Site() );
    }

    inline function doRecords( d : Dispatch ) {
        d.dispatch( new drylungs.web.Records() );
    }

    inline function doFeed( d : Dispatch ) {
        d.dispatch( new drylungs.web.Feed() );
    }

    inline function doAtom( d : Dispatch ) doFeed( d );
    inline function doSyndication( d : Dispatch ) doFeed( d );

    inline function do666() {
        Sys.print( '666' );
    }

    /*
    inline function doBlog( d : Dispatch ) {
        //d.dispatch( new drylungs.web.Blog() );
    }
    */

}
