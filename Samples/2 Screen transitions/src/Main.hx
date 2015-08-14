package;

import com.creativemage.screenManager.ScreenManager;
import openfl.display.Sprite;
import openfl.Lib;
import src.screens.ScreenList;

/**
 * ...
 * @author Alex Kolpakov
 * 
 * This sample expects that you've already seen the `1 Basics` sample.
 * 
 * In this sample you will be presented with a simplistic app made out of three screens. Each of those screens will use different animation to navigate to another screen.
 * Also in this sample you will be presented with a sample screen transation effect class - ImageFade.
 * 
 */
class Main
{

	public function new() 
	{
		setScreenManager();
	}
	
	// Setting up and initing the screen manager
	function setScreenManager()
	{
		var portWidth:Int = Lib.current.stage.stageWidth;
		var portHeight:Int = Lib.current.stage.stageHeight;
		
		var screenManager = new ScreenManager( Lib.current.stage, portWidth, portHeight, new ScreenList() );
		screenManager.init();
	}

}
