package com.creativemage.screenManager.transitionEffect;
import com.creativemage.screenManager.AScreen;
import com.creativemage.screenManager.ScreenManager;
import openfl.errors.Error;


/**
 * ...
 * @author Creative Magic
 */
@:access(com.creativemage.screenManager)
class AScreenTransition
{
	public var transitionManager:ScreenTransitionManager;
	public var screenManager:ScreenManager;
	
	public var animationTime_ms:Int = 0;
	
	private var screenA(get, never):AScreen;
	private var screenB(get, never):AScreen;

	public function new(time_ms:Int)
	{
		animationTime_ms = time_ms;
	}
	
	public function start():Void
	{
		throw new Error( "this method needs to be overridden" ); 
	}
	
	public function onFinish():Void
	{
		transitionManager.finishTransition();
	}
	
	// GETTERS AND SETTERS
	
	private function get_screenA():AScreen
	{
		return transitionManager.screenA;
	}
	
	private function get_screenB():AScreen
	{
		return transitionManager.screenB;
	}
	
}