package drylungs;

import om.http.StatusCode;

typedef Site = Dynamic;

class Web {

    public static var isMobile(default,null) : Bool;
    public static var site(default,null) : Site;

    /*
    function printErrorPage( code : Int, ?message : String ) {
        php.Web.setReturnCode( code );
        var html = HTML.build( 'error', { page: 'error', code: code, message: message } );
        Sys.print( html );
    }
    */

    static function sendError( code : Int, ?message : String ) {
        php.Web.setReturnCode( code );
        //Sys.print( code );
        if( message != null ) Sys.print( message );
    }

    static function main() {

        site = Json.parse( File.getContent( Drylungs.DATA+'/site.json' ) );

        var uri = php.Web.getURI();
        var params = php.Web.getParams();
        var isMobile = om.System.isMobile();
        var now = Date.now();
        var ip = php.Web.getClientIP();

        Template.globals = {

            REVISION: Drylungs.REVISION,
            VERSION: Drylungs.VERSION,
            GIT_COMMIT: Drylungs.GIT_COMMIT,
            BUILDTIME: Drylungs.BUILDTIME,
            DEBUG: Drylungs.DEBUG,

            mobile: isMobile,
            device : isMobile ? 'mobile' : 'desktop',
            language: site.language,
            platform: 'php',

            site: site,
            theme: site.color.theme
            //color: site.color.theme,
        };
        for( f in Reflect.fields( site ) )
            Reflect.setField( Template.globals, f, Reflect.field( site, f ) );

        //TODO remove
        /*
        var testfile = 'data/test';
        try {
            var f =  if( FileSystem.exists( testfile )) File.append( testfile ) else File.write( testfile );
            f.writeString( now+' - '+ip+ ' - '+php.Web.getClientHeaders()+'\n' );
            f.close();
        } catch(e:Dynamic) {
            trace(e);
            return;
        }
        */

        var dispatcher = new Dispatch( uri, params );
        dispatcher.onMeta = function(meta,value) {
            switch meta {
            case 'admin': throw 'not allowed';
            }
        }
        try {
            dispatcher.dispatch( new drylungs.web.Root() );
        } catch( e : DispatchError ) {
            switch e {
            case DENotFound(part):
                php.Web.setReturnCode( 404 );
                Sys.print( new Template( Resource.get('error') ).execute({ code: 404, message: 'Not Found' }) );
                return;
                //sendError( StatusCode.NOT_FOUND, 'not found' );
            case DEInvalidValue:
            case DEMissing:
            case DEMissingParam(p):
            case DETooManyValues:
            }
            trace(e);
        } catch( e : Dynamic ) {
            Sys.print( "FATAL ERROR: " + e );
        }
    }

}
