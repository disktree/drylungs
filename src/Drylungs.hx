
#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;
#end

#if !macro @:build(Drylungs.build()) #end
class Drylungs {

	#if macro

	static function build() : Array<Field> {

        var fields = Context.getBuildFields();
		var pos = Context.currentPos();

		var time = Date.now().toString();
		var version = Compiler.getDefine( 'version' );

		if( version != null ) {
			fields.push({
				name: 'VERSION',
				access: [AStatic,APublic,AInline],
				kind: FVar( macro : String, macro $v{version} ),
				pos: pos
			});
		}

		fields.push({
			name: 'BUILDTIME',
			access: [AStatic,APublic,AInline],
			kind: FVar( macro : String, macro $v{time} ),
			pos: pos
		});

        return fields;
    }

	#end

}
