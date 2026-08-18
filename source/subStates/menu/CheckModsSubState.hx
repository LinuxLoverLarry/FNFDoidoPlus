class ModManger extends MusicBeatSubState {
	public static function listMods():Array<String> {
		return Polymod.getLoadedModIds();	
	}

	public static function reloadMods(modIds:Array<String> = null):Void {
		Polymod.unload();
		Polymod.init({
			modRoot: "mods",
			dir: modIds,
			frameworks: [Polymod.Framework.FLIXEL],
			parseRules: ParseRule.getFlixelParseRules()
		)};
		Main.gFont = Paths.font("vcr.ttf");
	}
}