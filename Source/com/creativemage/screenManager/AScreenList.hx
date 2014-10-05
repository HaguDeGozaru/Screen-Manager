package com.creativemage.screenManager;
import flash.errors.Error;

/**
 * ...
 * @author Creative Magic
 */
class AScreenList
{
	public var lastSelectedID:Int;
	private var pairList:Array<ScreenPair>;

	public function new() 
	{
		pairList = new Array<ScreenPair>();
	}
	
	public function push(screenName:String, screenClass:Class<AScreen>):Void
	{
		var pair:ScreenPair = new ScreenPair();
		pair.screenName = screenName;
		pair.screenClass = screenClass;
		pairList.push(pair);
	}
	
	public function getClassByID(id:Int):Class<AScreen>
	{
		return pairList[id].screenClass;
	}
	
	public function getClassByName(name:String):Class<AScreen>
	{
		var currentPair:ScreenPair;
		
		for (i in 0...pairList.length)
		{
			currentPair = pairList[i];
			
			if (currentPair.screenName == name)
			{
				lastSelectedID = i;
				return currentPair.screenClass;
			}
		}
		throw new Error("No such screen was found in ScreenList.hx");
		return null;
	}
	
}

private class ScreenPair
{
	public var screenName:String;
	public var screenClass:Class<AScreen>;
	
	public function new()
	{
		
	}
}