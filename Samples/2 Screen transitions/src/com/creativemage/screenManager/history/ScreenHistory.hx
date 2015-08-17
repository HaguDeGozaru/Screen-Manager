package com.creativemage.screenManager.history;

/**
 * ...
 * @author Alex Kolpakov
 */
class ScreenHistory
{
	public var screenIdList:Array<Int> = [];
	private var currentHistoryPosition:Int = 0;
	
	public function new() 
	{
		
	}
	
	public function writeToHistory( nextScreenId:Int ):Void
	{
		screenIdList = screenIdList.slice( 0, currentHistoryPosition);
		screenIdList.push ( nextScreenId );
		
		currentHistoryPosition = screenIdList.length - 1;
	}
	
	public function stepBack():Int
	{
		if ( currentHistoryPosition <= 0 )
			return 0;
		
		currentHistoryPosition--;
		
		return screenIdList[currentHistoryPosition];
	}
	
	public function stepForward():Int
	{
		if ( currentHistoryPosition <= screenIdList.length - 1 )
			return screenIdList.length - 1;
		
		currentHistoryPosition++;
		
		return screenIdList[currentHistoryPosition];
	}
	
	public function getCurrentScreenId():Int
	{
		return screenIdList[currentHistoryPosition];
	}
	
}