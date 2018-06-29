package drylungs;

import om.http.StatusCode;

typedef Site = Dynamic;

class Web {

    public static inline var PATH = '';
    public static inline var SITE = 'site';

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

        site = Json.parse( File.getContent( '$SITE/site.json' ) );

        var uri = php.Web.getURI();
        var path = uri.substr( PATH.length );
        var params = php.Web.getParams();
        var isMobile = om.System.isMobile();

        Template.globals = {

            mobile: isMobile,
            device : isMobile ? 'mobile' : 'desktop',
            lang: 'en',
            platform: 'php',

            version: Drylungs.VERSION,
            buildtime: Drylungs.BUILDTIME,

            uri: site.uri,
            title: site.title,
            description: site.description,
            keywords: site.keywords,
            color: site.color.theme
            //description: 'Dry Lungs Records &amp; Mailorder',
            //keywords: ['drylungs','mailorder'],
            //keywords: ["wtf"],
            //color: '#0c0c0c',
        };

        var dispatcher = new Dispatch( path, params );
        dispatcher.onMeta = function(meta,value) {
            switch meta {
            case 'admin': throw 'not allowed';
            }
        }
        try {
            dispatcher.dispatch( new drylungs.web.Root() );
        } catch( e : DispatchError ) {
            trace(e);
            switch e {
            case DENotFound(part):
                sendError( StatusCode.NOT_FOUND, 'not found' );
            case DEInvalidValue:
            case DEMissing:
            case DEMissingParam(p):
            case DETooManyValues:
            }
        } catch( e : Dynamic ) {
            Sys.print( "FATAL ERROR: " + e );
        }
    }

}
