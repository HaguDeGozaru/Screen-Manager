package src.screens;
import com.creativemage.screenManager.AScreenList;
import src.screens.ScreenA;
import src.screens.ScreenB;
import src.screens.ScreenC;

/**
 * ...
 * @author Alex Kolpakov
 */
class ScreenList extends AScreenList
{
	
	public static inline var SCREEN_A:String = "screen a";
	public static inline var SCREEN_B:String = "screen b";
	public static inline var SCREEN_C:String = "screen c";

	public function new() 
	{
		super();
		
		push( SCREEN_A, ScreenA );
		push( SCREEN_B, ScreenB );
		push( SCREEN_C, ScreenC );
	}
	
}