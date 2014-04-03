package  
{
	import org.flixel.*;

	
	public class BadFood extends FlxSprite
	{
		[Embed(source = "/assets/badfoods.png")]
		private static var food_sheet:Class;
		
		var y_origin:Number;
		var move:Number;
		var counter:Number = 0;
		var random:Number;
		
		public function BadFood(x:Number, y:Number) 
		{
			super(x, y);
			y_origin = y;
			loadGraphic(food_sheet, false, false, 50, 40);
			
			random = Math.ceil(Math.random() * 2);
			if (random == 1)
				move = 1;
			else if (random == 2)
				move = -1;
				
			randomFrame();
		}
		
		override public function update():void {
			super.update();
			
			counter += 1;
			if (counter >= 6) {
				
				counter = 0;
				
				y  += move;
				
				if (y >= y_origin + 3) {
					move = -1;
				}
				else if (y <= y_origin - 3) {
					move = 1;
				}
			}
		}
	}

}