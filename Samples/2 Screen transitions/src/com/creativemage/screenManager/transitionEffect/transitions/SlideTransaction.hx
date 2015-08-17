package com.creativemage.screenManager.transitionEffect.transitions;
import com.creativemage.screenManager.transitionEffect.AScreenTransition;
import motion.Actuate;
import motion.easing.Linear;

/**
 * ...
 * @author Creative Magic
 */
class SlideTransaction extends AScreenTransition
{
	public inline static var FROM_LEFT_TO_RIGHT:String = "lr";
	public inline static var FROM_RIGHT_TO_LEFT:String = "rl";
	public inline static var FROM_TOP_TO_BOTTOM:String = "tb";
	public inline static var FROM_BOTTOM_TO_TOP:String = "bt";
	
	public inline static var SLIDE_BOTH_SCREENS:String = "slideBothScreens";
	public inline static var SLIDE_NEW_SCREEN:String = "slideNewScreenOnly";
	//
	//private var direction:String;
	//private var option:String;
	//
	//private var screenADestX:Float = 0;
	//private var screenADestY:Float = 0;
	//
	//private var screenBDestX:Float = 0;
	//private var screenBDestY:Float = 0;
//
	public function new(slideDirection:String = FROM_RIGHT_TO_LEFT, slideOption:String = SlideTransaction.SLIDE_BOTH_SCREENS, convertScreensToBitmap:Bool = true) 
	{
		super( 0 );
	}
	//
	//override private function start():Void
	//{
		//switch (direction)
		//{
			//case FROM_BOTTOM_TO_TOP:
				//{
				//screenImageB.y = screenRefB.screenHeight;
				//
				//screenADestY = - screenRefA.screenHeight;
				//screenBDestY = 0;
				//}
				//
			//case FROM_LEFT_TO_RIGHT:
			//{
				//screenImageB.x = -screenRefB.screenWidth;
				//
				//screenADestX = screenRefA.screenWidth;
				//screenBDestX = 0;
			//}
				//
			//case FROM_RIGHT_TO_LEFT:
			//{
				//screenImageB.x = screenRefB.screenWidth;
				//
				//screenADestX = - screenRefA.screenWidth;
				//screenBDestX = 0;
			//}
				//
			//case FROM_TOP_TO_BOTTOM:
			//{
				//screenImageB.y = -screenRefB.screenHeight;
				//
				//screenADestY = screenRefA.screenHeight;
				//screenBDestY = 0;
			//}
		//}
		//
		//Actuate.tween(screenImageB, transationTime / 1000, { x: screenBDestX, y: screenBDestY } ).ease(Linear.easeNone);
		//if (option == SLIDE_BOTH_SCREENS)
		//Actuate.tween(screenImageA, transationTime / 1000, { x: screenADestX, y: screenADestY } ).ease(Linear.easeNone);
		//
		//
	//}
}