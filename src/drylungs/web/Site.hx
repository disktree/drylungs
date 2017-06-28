package drylungs.web;

import haxe.Resource;
import haxe.Template;
import sys.FileSystem;
import sys.io.File;

using StringTools;
using haxe.io.Path;

class Site {

    public function new() {}

    function doDefault( id : String ) {

        if( id.length == 0 ) id = 'start';

        var dir = Web.CONTENT + '/site';
        var path = '$dir/$id';
        var extension : String = null;
        for( ext in ['md','html'] ) {
            if( FileSystem.exists( '$dir/$id.$ext' ) ) {
                extension = ext;
            }
        }

        var file = '$id.$extension';
        var filepath = '$dir/$file';
        if( !FileSystem.exists( filepath ) ) {
            Sys.print( "404 - Not Found");
            return;
        }

        var content = File.getContent( filepath );
        content = new Template( content ).execute( Web.context );

        switch extension {
        case 'md':
            content = Markdown.markdownToHtml( content );
        }

        Web.context.content = content;
        Web.context.site = id;

        print( Web.context );
    }

    public static inline function getTemplate( file : String ) : Template {
        return new Template( File.getContent( 'tpl/' + file ) );
    }

    public static inline function executeTemplate( file : String, ?context : Dynamic ) : String {
        if( context == null ) context = Web.context;
        return getTemplate( file ).execute( context );
    }

    public static inline function printTemplate( file : String, ?context : Dynamic ) {
        Sys.print( executeTemplate( file, context ) );
    }

    public static inline function print( ?context : Dynamic ) {
        Sys.print( executeTemplate( 'site.html', context ) );
    }

    /*
    static function findFile( dir : String, id : String ) : String {
        var found = new Array<String>();
        for( f in FileSystem.readDirectory( dir ) ) {
            var name = f.withoutExtension();
            if( name == id ) found.push( f );
            //var ext = f.extension();
            //if( f.withoutExtension() == id ) return f;
        }
        return null;
    }
    */
}
