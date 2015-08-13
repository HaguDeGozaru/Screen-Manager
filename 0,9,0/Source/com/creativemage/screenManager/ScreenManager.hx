package com.creativemage.screenManager;

import com.creativemage.screenManager.AScreen;
import flash.display.DisplayObjectContainer;
import com.creativemage.screenManager.transaction.AScreenTransaction;

/**
 * ...
 * @author Creative Magic
 */
class ScreenManager
{
	private var targetDisplayObjectContainer:DisplayObjectContainer;
	
	private var width:Int;
	private var height:Int;
	
	private var currentScreen:AScreen;
	
	private var inited:Bool = false;
	
	private var historyIDArray:Array<Int> = [];
	private var screenClassList:AScreenList;
	
	private var currentTransition:AScreenTransaction;
	var t:haxe.Timer;

	public function new(targetContainer:DisplayObjectContainer, frameWidth:Int, frameHeight:Int, ?predefinedScreenList:AScreenList) 
	{	
		width = frameWidth;
		height = frameHeight;
		
		targetDisplayObjectContainer = targetContainer;
		
		screenClassList = (predefinedScreenList == null) ? new AScreenList() : predefinedScreenList;
	}
	
	// PUBLIC METHODS
	
	public function init(startScreenID:Int = 0):Void
	{		
		currentScreen = createScreenInstance( screenClassList.getClassByID(startScreenID) );
		targetDisplayObjectContainer.addChild(currentScreen);
		currentScreen.onInit();
	}
	
	public function gotoScreenByID(screenID:Int, ?transition:AScreenTransaction, transactionTime:Int = 0, useHistory:Bool = true):Void
	{
		var nextScreenClass:Class<AScreen> = screenClassList.getClassByID(screenID);
		gotoScreen(nextScreenClass, screenClassList.lastSelectedID, transition, transactionTime);
	}
	
	public function gotoScreenByName(screenName:String, ?transition:AScreenTransaction, transactionTime:Int = 0, useHistory:Bool = true):Void
	{
		var nextScreenClass:Class<AScreen> = screenClassList.getClassByName(screenName);
		gotoScreen(nextScreenClass, screenClassList.lastSelectedID, transition, transactionTime);
	}
	
	public function addScreenClass(screenClass:Class<AScreen>, screenName:String) 
	{
		screenClassList.push(screenName, screenClass);
	}
	
	//TODO: test this
	public function goBack():Void
	{
		if (historyIDArray.length == 1)
			return;
			
		var targetScreenID:Int = historyIDArray[historyIDArray.length - 2];
		historyIDArray.splice(historyIDArray.length - 1, 1);
		gotoScreenByID(targetScreenID, null, 0, false);
	}
	
	// PRIVATE METHODS
	
	function disposeOfCurrentScreen() 
	{
		currentScreen.removeAllListenerObjects();
		targetDisplayObjectContainer.removeChild(currentScreen);
		currentScreen = null;
	}
	private function createScreenInstance(screenClass:Class<AScreen>):AScreen
	{
		var screenInstance:AScreen = Type.createInstance(screenClass, []);
		screenInstance.screenWidth = width;
		screenInstance.screenHeight = height;
		screenInstance.managerRef = this;
		
		return screenInstance;
	}
	
	private function gotoScreen(screenClass:Class<AScreen>, screenID:Int, transition:AScreenTransaction, transactionTime:Int = 0, useHistory:Bool = true)
	{
		if (useHistory == true)
			historyIDArray.push(screenID);
		
		// if going to another screen before the previous transition has finished, - stop the timer
		if (t != null)
			t.stop();
		
		// remove all event listeners from current screen
		currentScreen.removeAllListenerObjects();
		
		// make the new screen
		var nextScreen:AScreen = createScreenInstance(screenClass);
		targetDisplayObjectContainer.addChild(nextScreen);
		
		if (transactionTime <= 0)
		{
			disposeOfCurrentScreen();
			currentScreen = nextScreen;
			targetDisplayObjectContainer.addChild(nextScreen);
			nextScreen.onInit();
		}
		else
		{
			nextScreen.visible = false;
			
			t = new haxe.Timer(transactionTime);
			t.run = function():Void
			{
				disposeOfCurrentScreen();
				currentScreen = nextScreen;
				targetDisplayObjectContainer.addChild(nextScreen);
				
				if (transition == null)
					nextScreen.onInit();
				else
					nextScreen.enableAllListenerObjects();
				nextScreen.visible = true;
				t.stop();
			};
			
			if (transition != null)
			{
				currentTransition = transition;
				currentTransition.screenRefA = currentScreen;
				currentTransition.screenRefB = nextScreen;
				currentTransition.transationTime = transactionTime;
				currentTransition.targetHolder = targetDisplayObjectContainer;
				
				currentTransition.init(true);
			}
		}
	}
	
}      