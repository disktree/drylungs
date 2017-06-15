package drylungs.web;

import haxe.Json;
import haxe.Resource;
import haxe.Template;
import sys.FileSystem;
import sys.io.File;

using StringTools;
using haxe.io.Path;

typedef Track = {
    var title : String;
    @:optional var duratrion : String;
}

typedef Record = {
    var index : Int;
    var title : String;
    var date : String;
    var artists : Array<String>;
    var format : String;
    @:optional var description : String;
    @:optional var notes : String;
    @:optional var tracks : String;
}

class Records {

    public function new() {
    }

    public function doDefault( ?id : String ) {

        if( id.length == 0 ) {

            var records = getAll();

            var content = new Template( Resource.getString( 'records' ) ).execute( { records: records } );

            Web.context.content = content;
            Web.context.site = 'records';

            var html = new Template( Resource.getString( 'site' ) ).execute( Web.context );
            Sys.print( html );

        } else {

            var record = get( id );

            var content = new Template( Resource.getString( 'record' ) ).execute( record );

            Web.context.content = content;
            Web.context.site = 'record';

            var html = new Template( Resource.getString( 'site' ) ).execute( Web.context );
            Sys.print( html );
        }
    }

    public static function getAll() : Array<Record> {

        var dir = 'content/record';
        var records = new Array<Record>();
        for( f in FileSystem.readDirectory( dir ) ) {
            if( f.extension() != 'json' )
                continue;
            var id = f.withoutExtension();
            var rec = get( id );
            records.push( rec );
        }

        records.sort( function(a,b){
            return (a.index > b.index ) ? -1 : (a.index < b.index) ? 1 : 0;
        });

        return records;
    }

    public static function get( id : String ) : Record {
        var path = 'content/record/$id.json';
        var record = Json.parse( File.getContent( path ) );
        record.id = id;
        return record;
    }

}
