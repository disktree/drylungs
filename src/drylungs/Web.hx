package drylungs;

#if !macro @:build(drylungs.macro.BuildApp.build()) #end
class Web {

    public static inline var PATH = '';
    public static inline var SITE = 'site';

    public static var isMobile(default,null) : Bool;
    public static var context(default,null) : Dynamic;
    public static var dispatcher(default,null) : Dispatch;

    static function main() {

        drylungs.Build.icons();

        isMobile = om.System.isMobile();
        context = Json.parse( File.getContent( '$SITE/site.json' ) );

        var uri = php.Web.getURI();
        var path = php.Web.getURI().substr( PATH.length );
        var params = php.Web.getParams();

        Template.globals = {
            mobile: isMobile,
            device : isMobile ? 'mobile' : 'desktop',
            version: VERSION,
            platform: 'php',
        };

        dispatcher = new Dispatch( path, params );
        dispatcher.onMeta = function(meta,value) {
            //trace(meta,value);
        }
        try dispatcher.dispatch( new drylungs.web.Root() ) catch(e:Dynamic) {
            //php.Web.setReturnCode( 404 );
            switch e {
            case DENotFound(part):
            case DEInvalidValue:
            case DEMissing:
            case DEMissingParam(p):
            case DETooManyValues:
                //dispatcher.redirect( '/' );
                //dispatcher.dispatch( root );
            }
            Sys.print( e );
        }
    }

}
