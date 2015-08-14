package src.screens;
import com.creativemage.screenManager.AScreenList;
import src.screens.ScreenA;
import src.screens.ScreenB;

/**
 * ...
 * @author Alex Kolpakov
 * 
 * 
 * A screen list is just a collection of screens that is provided to the ScreenManager class instance.
 * It's better to make a predefined list for several reasons:
 * 
 *  1) You can keep your code base cleaner. All the `import` statements are defined in this class. It's also easier to search where you define classes for different screen managers (yes, you can have more than one)
 *  2) Using static constants it's just easier access screen names without having a chance to mistype the name a have a silent error.
 * 
 */



 
class MyScreenList extends AScreenList
{
	
	// Look at ScreenA class and see how this comes in handy
	public static inline var SCREEN_A:String = "screen a";
	public static inline var SCREEN_B:String = "screen b";

	public function new() 
	{
		super();
		
		// push all screen classes that belong to this screen list
		// you can also add screens to the list on run-time but I never had a good reason to do so
		push( SCREEN_A, ScreenA );
		push( SCREEN_B, ScreenB );
	}
	
}