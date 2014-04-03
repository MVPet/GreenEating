package  
{
	import org.flixel.*;

	public class Food extends FlxSprite
	{
		[Embed(source = "/assets/foods.png")]
		private static var food_sheet:Class;
		
		var y_origin:Number;
		var yvel:Number = 0;
		var ydis:Number = 0;
		var move:Number;
		var counter:Number = 0;
		var random:Number;
		var random_flip:Number;
		
		public function Food(x:Number, y:Number) 
		{
			super(x, y);
			y_origin = y;
			loadGraphic(food_sheet, false, false, 50, 40);
			
			random_flip = Math.ceil(Math.random() * 2);
			if (random_flip == 1)
				scale = new FlxPoint(1, 1);
			else if (random_flip == 2)
				scale = new FlxPoint( -1, 1);
			
			random = Math.ceil(Math.random() * 2);
			if (random == 1)
				move = 0.3;
			else if (random == 2)
				move = -0.3;
			
			//instead fo randomizing this, I could use the randomframe function (look it up if I need to)
			//it'll remove the switch and the previous random
			/*switch(type) {
				case 1:
					addAnimation("ban", [0], 10, true);
					play("ban");
					break;
				case 2:
					addAnimation("broc", [1], 10, true);
					play("broc");
					break;
				case 3:
					addAnimation("car", [2], 10, true);
					play("car");
					break;
				case 4:
					addAnimation("chip", [3], 10, true);
					play("chip");
					break;
				case 5:
					addAnimation("soda", [4], 10, true);
					play("soda");
					break;
			}*/
			
			randomFrame();
		}
		
		override public function update():void {
			super.update();			
			
			
				yvel = (1 - (Math.abs(y - y_origin) / 7)) * move;
			
				if (Math.abs(yvel) <= 0.05) {
					move *= -1;
					yvel = 0.05 * (Math.abs(move) / move);
				}
				
				y += yvel;
			
			/*counter += 1;
			if (counter >= 10) {
				
				counter = 0;
				
				y  += move;
				
				if (y >= y_origin + 3) {
					move = -1;
				}
				else if (y <= y_origin - 3) {
					move = 1;
				}
			}*/
		}
		
	}

}