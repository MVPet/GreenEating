package  
{
	import org.flixel.*;
	
	public class Scientist extends FlxSprite
	{
		[Embed(source = "/assets/science.png")]
		private static var scientist:Class;
		
		[Embed(source = "/assets/fscience.png")]
		private static var f_scientist:Class;
		
		[Embed(source = "/assets/iscience.png")]
		private static var i_scientist:Class;
		
		[Embed(source = "/assets/cscience.png")]
		private static var c_scientist:Class;
		
		[Embed(source = "/assets/ascience.png")]
		private static var a_scientist:Class;

		var move:Number = 3;
		var counter:Number = 0;
		var random:Number = 0;
		var randomScientist:Number;
		var randomLoc:Number;
		var loc:Number;
		var stop:Boolean = false;
		
		public function Scientist(y_loc:Number) 
		{
			loc = Math.ceil(Math.random() * 440)+80;
			
			super(loc, y_loc);
		
			
			randomScientist = Math.ceil(Math.random() * 5);
			scale = new FlxPoint( -1, 1);
			
			if(randomScientist == 2)
				loadGraphic(f_scientist, true, false, 60, 100);
			else if(randomScientist == 1)
				loadGraphic(scientist, true, false, 60, 100);
			else if(randomScientist == 4)
				loadGraphic(i_scientist, true, false, 60, 100);
			else if(randomScientist == 5)
				loadGraphic(c_scientist, true, false, 60, 100);
			else if(randomScientist == 3)
				loadGraphic(a_scientist, true, false, 60, 100);
			
			addAnimation("walk", [0, 1], 7, true);
			addAnimation("stand", [0], 7, true);
			play("walk");
		}
		
		override public function update():void {
			super.update();
			
			counter++;
			if (counter >= 6) {
				
				random = Math.ceil(Math.random() * 26);
				if (random == 1) {
					play("walk");
					stop = false;
					scale.x *= -1;
					move *= -1;
				}
				if (random == 2) {
					play("stand");
					stop = true;
				}
				
				counter = 0;
				
				if(!stop) {
					x += move;
					if (x >= FlxG.width)
						x = 0;
					if ( x <= 0)
						x = FlxG.width;
				}
			}
		}
		
	}

}