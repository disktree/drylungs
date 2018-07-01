package drylungs.web;

class HTML {

	var id : String;
	var resource : String;
	var site : Dynamic;

	public function new( id : String, ?site : Dynamic, ?resource = 'index' ) {
		this.id = id;
		this.site = (site == null) ? {} : site;
		this.resource = resource;
	}

	public function build( ctx : Dynamic ) : String {

		site.id = id;
		site.content = new Template( File.getContent( 'html/site/$id.html' ) ).execute( ctx );
		if( ctx.title != null ) site.title = ctx.title;

		return new Template( Resource.get( resource ) ).execute( site );
	}
}

/*
@:keep
private class TemplateContext {

    public function new() {}

    public function html( resolve : String->Dynamic, id : String ) {
        return Resource.getString( 'tpl_$id' );
    }
}
*/
