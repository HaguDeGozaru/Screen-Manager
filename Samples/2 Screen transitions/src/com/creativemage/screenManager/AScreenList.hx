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
	private var uniqueId:Int = 0;

	public function new() 
	{
		pairList = new Array<ScreenPair>();
	}
	
	public function push(screenName:String, screenClass:Class<AScreen>):Void
	{
		var pair:ScreenPair = new ScreenPair();
		pair.screenName = screenName;
		pair.screenClass = screenClass;
		pair.screenId = uniqueId;
		pairList.push(pair);
		
		uniqueId++;
	}
	
	public function getClassByID(id:Int):Class<AScreen>
	{
		
		for (screenPair in pairList)
			if (screenPair.screenId == id)
			{
				lastSelectedID = id;
				return screenPair.screenClass;
			}
			
		throw new Error("No such screen was found in the screen list");
		return null;
	}
	
	public function getClassByName(name:String):Class<AScreen>
	{
		for (screenPair in pairList)
			if (screenPair.screenName == name)
			{
				lastSelectedID = screenPair.screenId;
				return screenPair.screenClass;
			}
		
		throw new Error("No such screen was found in the screen list");
		return null;
	}
	
	public function getScreenPairByName(screenName:String) 
	{
		for (screenPair in pairList)
			if (screenPair.screenName == name)
			{
				lastSelectedID = screenPair.screenId;
				return screenPair;
			}
		
		throw new Error("No such screen was found in the screen list");
		return null;
	}
	
}

private class ScreenPair
{
	public var screenName:String;
	public var screenId:Int;
	public var screenClass:Class<AScreen>;
	
	public function new()
	{
		
	}
}