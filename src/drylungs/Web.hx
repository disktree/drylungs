package drylungs;

import haxe.Resource;
import haxe.Template;
import haxe.web.Dispatch;
import om.Json;
import sys.FileSystem;
import sys.io.File;

class Web {

    public static inline var CONTENT = 'content';

    public static var context(default,null) : Dynamic;

    static function main() {

        //Session.start();

        var uri = om.Web.getURI();
        var params = om.Web.getParams();

        context = Json.parse( File.getContent( '$CONTENT/site.json' ) );
        context.content = '';
        context.mobile = om.Web.isMobile();

        var dispatcher = new Dispatch( uri, params );

        try {
            dispatcher.dispatch( new drylungs.web.Router() );
            //var html = new Template( Resource.getString( 'site' ) ).execute( context );
            //Sys.print( html );
        } catch( e : om.error.NotFound ) {
            Sys.print( "NotFound: "+e );
            return;
        } catch( e : DispatchError ) {
            Sys.print( 'DispatchError '+e );
            return;
        } catch( e : Dynamic ) {
            Sys.print( "ERROR:"+e );
            return;
        }
    }

}
