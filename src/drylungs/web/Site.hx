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

        var dir = 'content/site';
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

        var html = new Template( Resource.getString( 'site' ) ).execute( Web.context );
        Sys.print( html );
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
