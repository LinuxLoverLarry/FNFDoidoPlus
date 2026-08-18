package;

import backend.game.MusicBeatData.MusicBeatState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import states.*;
import sys.FileSystem;
import polymod.*;

class Init extends MusicBeatState
{
	override function create()
	{
		super.create();
		SaveData.init();
		DiscordIO.check();

		var dirs:Array<String> = null;
		var modDir = "mods";

		if (!FileSystem.exists(modsDir)) {
			try FileSystem.createDirectory(modsDir);
		}
		
		try {
			Polymod.init({
				modRoot: "mods",
				dirs:dirs,
				frameworks: [Polymod.Framework.FLIXEL]
			});
		} catch (e:Dynamic) {
			trace("Polymod initialization failed: " + e);
		}
		
		FlxG.fixedTimestep = false;
		FlxG.mouse.useSystemCursor = true;
		FlxG.mouse.visible = false;
		FlxGraphic.defaultPersist = true;
		
		for(i in 0...Paths.dumpExclusions.length)
			Paths.preloadGraphic(Paths.dumpExclusions[i].replace('.png', ''));

		firstState();
	}

	function firstState()
	{
		var openWarningMenu:Bool = #if html5 true #else false #end;

		if(FlxG.save.data.beenWarned == null || openWarningMenu)
			Main.switchState(new WarningState());
		else
			flagState();
	}

	/*
	* A function to call some of the engines build flags from
	* other states.
	*/
	public static function flagState()
	{
		#if MENU
		Main.switchState(new states.menu.MainMenuState());
		#elseif FREEPLAY
		Main.switchState(new states.menu.FreeplayState());
		#else
		Main.switchState(new TitleState());
		#end
	}
}
