package com.creativemage.screenManager.transitionEffect.transitions;
import com.creativemage.screenManager.transitionEffect.AScreenTransition;
import haxe.Timer;
import motion.easing.IEasing;
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
	
	private var easing:IEasing;

	public function new(targetColor:Int = 0x00, time_ms:Int, ?fadingOption:FadeOption, ?ease:IEasing) 
	{
		super(time_ms);
		
		fadeColor = targetColor;
		fadeOption = (fadingOption != null) ? fadingOption : FadeInOut;
		
		easing = (ease != null) ? ease : Linear.easeNone;
		
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
				Actuate.tween( overlay, animationTime_ms / 1000, { alpha: 1 } ).onComplete( onFinish, [] ).ease( easing );
			}
			case FadeOutOnly:
			{
				overlay.alpha = 1;
				swapScreens();
				Actuate.tween( overlay, animationTime_ms / 1000, { alpha: 0 } ).onComplete( onFinish, [] ).ease( easing );
			}
			
			case FadeInOut:
			{
				overlay.alpha = 0;
				Actuate.tween( overlay, animationTime_ms / 2000, { alpha: 1 } ).onComplete( onFinish, [] ).reflect( true ).repeat( 1 ).onRepeat( swapScreens, [] ).ease( easing );
			}
		}
		
		screenManager.targetDisplayObjectContainer.addChild( overlay );
	}
	
	private function swapScreens():Void
	{
		screenManager.deactivateScreen( screenA );
		screenManager.activateScreen( screenB );
		screenManager.targetDisplayObjectContainer.addChild( overlay );
	}
	
	override public function onFinish():Void 
	{
		screenManager.targetDisplayObjectContainer.removeChild( overlay );
		
		super.onFinish();
	}
	
}