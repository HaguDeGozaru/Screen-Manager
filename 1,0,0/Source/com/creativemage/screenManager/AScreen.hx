package com.creativemage.screenManager;

import com.creativemage.screenManager.transitionEffect.AScreenTransition;
import flash.display.Sprite;
import flash.errors.Error;
import flash.events.Event;
import flash.events.IEventDispatcher;

/**
 * ...
 * @author Creative Magic
 */

class AScreen extends Sprite
{
	public var screenWidth:Int;
	public var screenHeight:Int;
	
	private var listenerObjectArray:Array<ScreenEventListenerObject> = [];
	private var listenersEnabled:Bool = true;
	
	private var screenManager:ScreenManager;
	
	private var isInited:Bool = false;
	private var isActive:Bool = true;

	public function new() 
	{
		super();
	} 
	
	// SCREEN NAVIGATION
	private function gotoScreenByID(screenID:Int, ?transition:AScreenTransition):Void
	{
		screenManager.gotoScreenById(screenID, transition);
	}
	
	private function gotoScreenByName(screenName:String, ?transition:AScreenTransition):Void
	{
		screenManager.gotoScreenByName(screenName, transition);
	}
	
	private function goBack(?transition:AScreenTransition):Void
	{
		screenManager.goBack(transition);
	}
	
	private function goForward(?transition:AScreenTransition):Void
	{
		screenManager.goForward(transition);
	}
	
	// EVENT LISTENER UTILITIES
	private function addScreenListener(targetObject:IEventDispatcher, listenerType:String, handlerFuntion:Event -> Void):Void
	{
		targetObject.addEventListener(listenerType, handlerFuntion);
		
		var listenerObject:ScreenEventListenerObject = new ScreenEventListenerObject();
		listenerObject.object = targetObject;
		listenerObject.type = listenerType;
		listenerObject.handler = handlerFuntion;
		
		listenerObjectArray.push(listenerObject);
	}
	
	private function removeScreenListener(targetObject:IEventDispatcher, listenerType:String, handlerFuntion:Dynamic -> Void):Void
	{
		targetObject.removeEventListener(listenerType, handlerFuntion);
		
		var lObj:ScreenEventListenerObject;
		
		for (i in 0...listenerObjectArray.length)
		{
			lObj = listenerObjectArray[i];
			
			if (lObj.type == listenerType && lObj.object == targetObject && lObj.handler == handlerFuntion)
			{
				listenerObjectArray.splice(i, 1);
				targetObject.removeEventListener( listenerType, handlerFuntion);
				break;
			}
		}
	}
	
	public function removeAllListenerObjects():Void
	{
		var object:IEventDispatcher;
		var type:String;
		var handler:Dynamic -> Void;
		
		for (i in 0...listenerObjectArray.length)
		{
			object = listenerObjectArray[i].object;
			type = listenerObjectArray[i].type;
			handler = listenerObjectArray[i].handler;
			
			object.removeEventListener(type, handler);
		}
		
		listenerObjectArray = [];
	}
	
	public function disableAllListenerObjects():Void
	{
		if (listenersEnabled == false)
		return;
		
		listenersEnabled = false;
		
		var object:IEventDispatcher;
		var type:String;
		var handler:Dynamic -> Void;
		
		for (i in 0...listenerObjectArray.length)
		{
			object = listenerObjectArray[i].object;
			type = listenerObjectArray[i].type;
			handler = listenerObjectArray[i].handler;
			
			object.removeEventListener(type, handler);
		}
	}
	
	public function enableAllListenerObjects():Void
	{
		if (listenersEnabled == true)
		return;
		
		listenersEnabled = true;
		
		var object:IEventDispatcher;
		var type:String;
		var handler:Dynamic -> Void;
		
		for (i in 0...listenerObjectArray.length)
		{
			object = listenerObjectArray[i].object;
			type = listenerObjectArray[i].type;
			handler = listenerObjectArray[i].handler;
			
			object.addEventListener(type, handler);
		}
	}
	
	// EVENT HANDLERS
	
	/**
	 * This method is called when the screen is being initialized for the first time.
	 * Use this method as your constructor if you plan to use screenWidth/screenHeight, use screen history or screen navigation.
	 */
	private function onInit():Void
	{
		throw new Error("This method needs to be overriden");
	}
	
	/**
	 * This method is called when the screen is being activated. This will only trigger if the screen was de-activated before that.
	 * Otherwise the `onInit()` method will trigger
	 */
	private function onActivate():Void
	{
		
	}
	
	/**
	 * This method is called when the screen is being de-activated, but not completely removed from memory
	 */
	private function onDeactivate():Void
	{
		
	}
	
	/**
	 * This method is called when the transition effect is over. This is a good point to start animations var performance-heavy visual effects
	 */
	private function onScreenTransitionFinish():Void
	{
		
	}
	
	/**
	 * This method is called when the stage is being resized
	 */
	private function onResize():Void
	{
		
	}
	
	/**
	 * This method is called when the screen manager is about to remove this screen
	 */
	private function onRemove():Void
	{
		
	}
	
	
}

private class ScreenEventListenerObject
{
	public var object:IEventDispatcher;
	public var type:String;
	public var handler:Dynamic -> Void;
	
	public function new ()
	{
		
	}
}