package com.creativemage.screenManager;

import com.creativemage.screenManager.transaction.AScreenTransaction;
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
	private var listenerObjectArray:Array<ScreenEventListenerObject> = [];
	private var listenersEnabled:Bool = true;
	
	public var screenWidth:Int;
	public var screenHeight:Int;
	
	public var managerRef:ScreenManager;
	
	public var isInited:Bool = false;

	public function new() 
	{
		super();
	} 
	
	private function gotoScreenByID(screenID:Int, ?transition:AScreenTransaction, ?transactionTime:Int = 0 ):Void
	{
		managerRef.gotoScreenByID(screenID, transition, transactionTime);
	}
	
	private function gotoScreenByName(screenName:String, ?transition:AScreenTransaction, ?transactionTime:Int = 0):Void
	{
		managerRef.gotoScreenByName(screenName, transition, transactionTime);
	}
	
	private function goBack():Void
	{
		managerRef.goBack();
	}
	
	private function addScreenListener(targetObject:Dynamic, listenerType:String, handlerFuntion:Event -> Void):Void
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
	
	private function onScreenTransitionFinish():Void
	{
		
	}
	
	private function onResize():Void
	{
		
	}
	
	private function onRemove():Void
	{
		
	}
	
	private function onInit():Void
	{
		throw new Error("This method needs to be overriden");
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