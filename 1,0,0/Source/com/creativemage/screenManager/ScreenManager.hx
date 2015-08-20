package com.creativemage.screenManager;

import com.creativemage.screenManager.AScreen;
import com.creativemage.screenManager.history.ScreenHistory;
import com.creativemage.screenManager.transitionEffect.AScreenTransition;
import com.creativemage.screenManager.transitionEffect.ScreenTransitionManager;
import flash.display.DisplayObjectContainer;
import openfl.events.Event;
import openfl.Lib;

/**
 * ...
 * @author Creative Magic
 */
@:access( com.creativemage.screenManager )
class ScreenManager
{
	public var targetDisplayObjectContainer(default, null):DisplayObjectContainer;
	
	public var width(default, set):Int;
	public var height(default, set):Int;
	
	private var currentScreen:AScreen;
	
	private var inited:Bool = false;
	
	private var screenClassList:AScreenList;
	
	private var screenTransitionManager:ScreenTransitionManager;
	private var screenHistory:ScreenHistory;
	
	public var defaultScreenTransition:AScreenTransition;

	public function new(targetContainer:DisplayObjectContainer, frameWidth:Int, frameHeight:Int, ?predefinedScreenList:AScreenList) 
	{
		width = frameWidth;
		height = frameHeight;
		
		targetDisplayObjectContainer = targetContainer;
		
		screenClassList = (predefinedScreenList == null) ? new AScreenList() : predefinedScreenList;
		
		screenTransitionManager = new ScreenTransitionManager();
		screenTransitionManager.screenManager = this;
		
		screenHistory = new ScreenHistory();
	}
	
	// INITIALIZATION
	
	public function init(startScreenID:Int = 0, listenToResizeEvents:Bool = true, ?defaultTransitionEffect:AScreenTransition):Void
	{		
		currentScreen = createScreenInstance( screenClassList.getClassByID(startScreenID) );
		activateScreen( currentScreen );
		
		defaultScreenTransition = defaultTransitionEffect;
		
		if (listenToResizeEvents == true)
			Lib.current.stage.addEventListener( Event.RESIZE, onStageResize );
			
		//screenHistory.writeToHistory( startScreenID );
	}
	
	// SCREEN LIST
	
	public function addScreenClass(screenClass:Class<AScreen>, screenName:String) 
	{
		screenClassList.push(screenName, screenClass);
	}
	
	
	// SCREEN NAVIGATION & HISTORY
	
	public function gotoScreenById(screenID:Int, ?transition:AScreenTransition):Void
	{
		var screenClass = screenClassList.getClassByID( screenID );
		
		if (screenClass == null)
			return;
		
		screenTransitionManager.gotoScreen( screenClass, transition );
		screenHistory.writeToHistory( screenID );
	}
	
	public function gotoScreenByName(screenName:String, ?transition:AScreenTransition):Void
	{
		var screenPair = screenClassList.getScreenPairByName( screenName );
		var screenClass = screenPair.screenClass;
		
		if (screenClass == null)
			return;
		
		screenTransitionManager.gotoScreen( screenClass, transition );
		screenHistory.writeToHistory( screenPair.screenId );
	}
	
	public function goBack(?transition:AScreenTransition):Void
	{
		var screenId = screenHistory.stepBack();
		gotoScreenById( screenId, (transition == null) ? defaultScreenTransition : transition );
	}
	
	public function goForward(?transition:AScreenTransition):Void
	{
		var screenId = screenHistory.stepForward();
		gotoScreenById( screenId, (transition == null) ? defaultScreenTransition : transition );
	}
	
	// UTILITY METHODS
	
	function disposeOfCurrentScreen() 
	{
		currentScreen.onRemove();
		
		if ( currentScreen.parent != null )
			targetDisplayObjectContainer.removeChild(currentScreen);
			
		currentScreen = null;
	}
	
	private function createScreenInstance(screenClass:Class<AScreen>):AScreen
	{
		var screenInstance:AScreen = Type.createInstance(screenClass, []);
		screenInstance.screenWidth = width;
		screenInstance.screenHeight = height;
		screenInstance.screenManager = this;
		
		return screenInstance;
	}
	
	public function activateScreen(screenInstance:AScreen, addToDisplayList:Bool = true):Void
	{
		if ( screenInstance.isInited == false )
		{
			screenInstance.isInited = true;
			screenInstance.onInit();
		}
		else if ( screenInstance.isActive == true )
		{
			return;
		}
		
		screenInstance.isActive = true;
		screenInstance.onActivate();
		
		if ( addToDisplayList == true )
			targetDisplayObjectContainer.addChild( screenInstance );
	}
	
	public function deactivateScreen(screenInstance:AScreen, removeFromDisplayList:Bool = true):Void
	{
		if ( screenInstance.isActive == false )
		return;
		
		screenInstance.isActive = false;
		screenInstance.removeAllListenerObjects();
		
		if ( removeFromDisplayList == true )
			targetDisplayObjectContainer.removeChild( screenInstance );
			
		screenInstance.onDeactivate();
	}
	
	// EVENT HANDLERS
	
	private function onStageResize(e:Event):Void 
	{
		if (currentScreen == null)
			return;
		
		currentScreen.onResize();
	}
	
	// GETTERS AND SETTERS
	
	private function set_width(value:Int):Int
	{
		width = value;
		
		if ( currentScreen != null )
			currentScreen.onResize();
		
		return width;
	}
	
	private function set_height(value:Int):Int
	{
		height = value;
		
		if ( currentScreen != null )
			currentScreen.onResize();
			
		return height;
	}
	
}      