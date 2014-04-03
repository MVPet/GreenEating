package  
{
	import org.flixel.*;
	
	public class FoodParticle extends FlxParticle
	{
		[Embed(source = "/assets/foods.png")]
		private static var gFood:Class;
		
		[Embed(source = "/assets/badfoods.png")]
		private static var bFood:Class;
		
		public function FoodParticle(isBad:Boolean) 
		{
			super();
			if(isBad) 
				loadGraphic(bFood, false, false, 50, 40);
			else
				loadGraphic(gFood, false, false, 50, 40);
			
			randomFrame();
			exists = false;
		}
		
		override public function onEmit():void
		{
			drag = new FlxPoint(4, 0);
		}
		
	}

}