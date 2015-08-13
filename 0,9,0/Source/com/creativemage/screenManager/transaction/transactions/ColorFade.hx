package com.creativemage.screenManager.transaction.transactions;
import com.creativemage.screenManager.transaction.AScreenTransaction;
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
 
class ColorFade extends AScreenTransaction
{	
	private var fadeColor:Int;
	private var overlay:Bitmap;
	private var fadeOption:FadeOption;

	public function new(targetColor:Int = 0x00, ?fadingOption:FadeOption, convertScreensToBitmaps:Bool = true) 
	{
		super(convertScreensToBitmaps);
		
		fadeColor = targetColor;
		fadeOption = (fadingOption != null) ? fadingOption : FadeInOut;
		
	}
	
	function makeScreenOverlay() 
	{
		overlay = new Bitmap();
		overlay.bitmapData = new BitmapData(Std.int(screenRefA.width), Std.int(screenRefA.height), false, fadeColor);
	}
	
	override function start():Void 
	{
		makeScreenOverlay();
		targetHolder.addChild(overlay);
		
		switch (fadeOption)
		{
			case FadeInOnly:
			{
				screenRefB.visible = false;
				overlay.alpha = 0;
				Actuate.tween(overlay, transationTime * 0.001, { alpha: 1 } ).ease(Linear.easeNone).onComplete( function():Void{screenRefB.visible = true; targetHolder.removeChild(overlay);});
			}
			
			case FadeInOut:
			{
				screenRefB.visible = false;
				overlay.alpha = 0;
				Actuate.tween(overlay, transationTime * 0.0005, { alpha: 1 } ).ease(Linear.easeNone).repeat().reflect();
				
				var t = new haxe.Timer(transationTime >> 1);
				t.run = function():Void { t.stop(); screenRefB.visible = true;};
				
			}
			
			case FadeOutOnly:
			{
				overlay.alpha = 1;
				Actuate.tween(overlay, transationTime * 0.001, { alpha: 0 } ).ease(Linear.easeNone).onComplete(function():Void{ targetHolder.removeChild(overlay);});
			}
		}
	}
	
}