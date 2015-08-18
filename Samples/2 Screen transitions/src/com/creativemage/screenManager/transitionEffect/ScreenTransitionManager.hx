package com.creativemage.screenManager.transitionEffect;
import com.creativemage.screenManager.AScreen;
import com.creativemage.screenManager.ScreenManager;
import com.creativemage.screenManager.transitionEffect.AScreenTransition;

/**
 * ...
 * @author Alex Kolpakov
 */
@:access(com.creativemage.screenManager)
class ScreenTransitionManager
{
	public var screenManager:ScreenManager;
	private var currentTransitionEffect:AScreenTransition;
	
	private var screenA(get, never):AScreen;
	@:isVar private var screenB(get, null):AScreen;
	private var screenB_Class:Class<AScreen>;

	public function new() 
	{
		
	}
	
	private function gotoScreen(screenClass:Class<AScreen>, transition:AScreenTransition):Void
	{
		screenB_Class = screenClass;
		screenA.removeAllListenerObjects();
		
		if ( transition == null || transition.animationTime_ms <= 0)
		{
			finishTransition();
			return;
		}
		
		transition.screenManager = screenManager;
		transition.transitionManager = this;
		transition.start();
		
	}
	
	private function finishTransition():Void
	{
		screenManager.deactivateScreen( screenA );
		screenManager.disposeOfCurrentScreen();
		screenManager.activateScreen( screenB );
		
		screenManager.currentScreen = screenB;
		screenManager.currentScreen.onScreenTransitionFinish();
		
		screenB = null;
	}
	
	// GETTERS AND SETTERS
	
	function get_screenA():AScreen
	{
		return screenManager.currentScreen;
	}
	
	function get_screenB():AScreen
	{
		if ( screenB == null )
			screenB = screenManager.createScreenInstance( screenB_Class );
		
		return screenB;
	}
}