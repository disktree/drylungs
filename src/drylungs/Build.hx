package drylungs;

class Build  {

	macro public static function icons() {

		var path = 'res/icon';
		var svg = '$path/drylungs-icons.svg';
		var svgModtime = FileSystem.stat( svg ).mtime.getTime();

		for( id in [16,32,48,72,96,144,192,512,1024] ) {
			var dst = '$path/icon-$id.png';
			if( !FileSystem.exists( dst ) || FileSystem.stat( dst ).mtime.getTime() < svgModtime ) {
				Sys.command( 'inkscape --without-gui $svg --export-png $dst --export-id=icon-$id' );
			}
		}

		return macro null;
	}

}
