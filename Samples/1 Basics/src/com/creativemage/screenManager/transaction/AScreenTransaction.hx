package com.creativemage.screenManager.transaction;

import com.creativemage.screenManager.AScreen;
import com.creativemage.screenManager.ScreenManager;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.errors.Error;
import flash.events.TimerEvent;
import flash.geom.Rectangle;
import flash.utils.Timer;

/**
 * ...
 * @author Creative Magic
 */
class AScreenTransaction
{
	public var screenRefA:AScreen;
	public var screenRefB:AScreen;
	
	@:isVar private var screenImageA(get, null):DisplayObject;
	@:isVar private var screenImageB(get, null):DisplayObject;
	
	public var transationTime:Int;
	public var targetHolder:DisplayObjectContainer;
	
	private var covertToBitmap:Bool;
	

	public function new(convertScreensToBitmaps:Bool = false) 
	{
		covertToBitmap = convertScreensToBitmaps;
	}
	
	public function init(initNextScreen:Bool = false):Void
	{
		if (initNextScreen == true)
			screenRefB.onInit();
			
		screenRefB.visible = true;
		screenRefB.disableAllListenerObjects();
		
		start();
	}
	
	public function onTransactionEnd():Void
	{
		screenRefA.visible = true;
		screenRefB.visible = true;
		
		screenRefB.enableAllListenerObjects();
		
		if (covertToBitmap == true)
		{
			targetHolder.removeChild(screenImageA);
			targetHolder.removeChild(screenImageB);
		}
		
	}
	
	private function start():Void
	{
		throw new Error("THIS METHOD NEEDS TO BE OVERRIDDEN");
	}
	
	function bakeBitmap(targetScreen:AScreen):Bitmap
	{
		var bd:BitmapData = new BitmapData(targetScreen.screenWidth, targetScreen.screenHeight);
		bd.draw(targetScreen, null, null, null, new Rectangle(0, 0, targetScreen.screenWidth, targetScreen.screenHeight));
		return new Bitmap(bd);
	}
	
	// SETTERS AND GETTERS
	function get_screenImageA():DisplayObject 
	{
		if (covertToBitmap == true)
		{
			if (screenImageA != null)
				return screenImageA;
			
			screenImageA = bakeBitmap(screenRefA);
			targetHolder.addChild(screenImageA);
			return screenImageA;
		}
		else
		return screenRefA;
	}
	
	function get_screenImageB():DisplayObject
	{
		if (covertToBitmap == true)
		{
			if (screenImageB != null)
				return screenImageB;
			
			screenImageB = bakeBitmap(screenRefB);
			targetHolder.addChild(screenImageB);
			return screenImageB;
		}
		else
		return screenRefB;
	}
}