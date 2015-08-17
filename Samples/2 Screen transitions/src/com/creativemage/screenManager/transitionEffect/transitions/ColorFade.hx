package com.creativemage.screenManager.transitionEffect.transitions;
import com.creativemage.screenManager.transitionEffect.AScreenTransition;
import haxe.Timer;
import motion.easing.Linear;
import openfl.display.BitmapData;
import motion.Actuate;
import openfl.display.Bitmap;

/**
 * ...
 * @author Alex Kolpakov
 */
enum FadeOption
{
	FadeInOut;
	FadeInOnly;
	FadeOutOnly;
}
 
class ColorFade extends AScreenTransition
{	
	private var fadeColor:Int;
	private var overlay:Bitmap;
	private var fadeOption:FadeOption;

	public function new(targetColor:Int = 0x00, time_ms:Int, ?fadingOption:FadeOption) 
	{
		super(time_ms);
		
		fadeColor = targetColor;
		fadeOption = (fadingOption != null) ? fadingOption : FadeInOut;
		
	}
	
	function makeScreenOverlay() 
	{
		overlay = new Bitmap();
		overlay.bitmapData = new BitmapData(screenManager.width, screenManager.height, false, fadeColor);
	}
	
	override function start():Void
	{
		makeScreenOverlay();
		
		switch ( fadeOption )
		{
			case FadeInOnly:
			{
				overlay.alpha = 0;
				Actuate.tween( overlay, animationTime_ms / 1000, { alpha: 1 } ).onComplete( onFinish, [] );
				
				
			}
			case FadeOutOnly:
			{
				overlay.alpha = 1;
				swapScreens();
				Actuate.tween( overlay, animationTime_ms / 1000, { alpha: 0 } ).onComplete( onFinish, [] );
				
			}
			
			case FadeInOut:
			{
				overlay.alpha = 0;
				Actuate.tween( overlay, animationTime_ms / 2000, { alpha: 1 } ).onComplete( swapScreens, [] );
				Actuate.tween( overlay, animationTime_ms / 2000, { alpha: 0 } ).onComplete( onFinish, [] ).delay(animationTime_ms / 2000);
			}
		}
		
		screenManager.targetDisplayObjectContainer.addChild( overlay );
	}
	
	private function swapScreens():Void
	{
		screenManager.deactivateScreen( screenA );
		screenManager.activateScreen( screenB );
	}
	
	override public function onFinish():Void 
	{
		trace("finished transition");
		screenManager.targetDisplayObjectContainer.removeChild( overlay );
		
		super.onFinish();
		
	}
	
}