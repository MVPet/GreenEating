package  
{
	
	import org.flixel.*;
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	[Frame(factoryClass="Preloader")] //Tells Flixel to use the default preloader 
	
	public class Manager extends FlxGame
	{
		public function Manager() 
		{
			super(640,480,TitleScreen,1);
		}
	}

}