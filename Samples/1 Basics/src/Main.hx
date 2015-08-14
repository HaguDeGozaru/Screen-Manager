package;

import com.creativemage.screenManager.ScreenManager;
import openfl.display.Sprite;
import openfl.Lib;

import src.screens.MyScreenList;

/**
 * ...
 * @author Alex Kolpakov
 */
class Main
{

	public function new() 
	{
		/*
		 * 1 - create and setup the ScreenManager instance
		 */
		
		// you can provide the screen manager with any viewport size
		// the screen manager will later provide the specified size to the screen
		// providing the screen size does not mask the content. It's mostly used
		// to construct and resize the screen using the screenWidth/screenHeight
		// variables instaead of reaching for the stage instance.
		
		var portWidth:Int = Lib.current.stage.stageWidth;
		var portHeight:Int = Lib.current.stage.stageHeight;
		
		var screenList = new MyScreenList();
		
		var screenManager:ScreenManager = new ScreenManager( Lib.current.stage, portWidth, portHeight, screenList );
		
		/*
		 * 2 - init the ScreenManager instance
		 */
		
		screenManager.init(); // if you're not using a predefined screen list like me in the example - make sure you have at least one screen added before you call init()
		
		
		/**
		 * At this point the screen manager will add the screen to the holder provided and the setup of the ScreenManager is over.
		 * I'd suggest to look into the MyScreenList class to see how (and why) you can define a screen list.
		 * After that look into ScreenA/ScreenB classes. They will explain basics about extending the AScreen list.
		 */
	}

}
