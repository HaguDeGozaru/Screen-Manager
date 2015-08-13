package com.creativemage.screenManager;
import flash.events.IEventDispatcher;
import haxe.macro.Expr.Function;

/**
 * ...
 * @author Creative Magic
 */
class ScreenEventListenerObject
{
	public var object:IEventDispatcher;
	public var type:String;
	public var handler:Dynamic -> Void;
	
	public function new ()
	{
		
	}
}