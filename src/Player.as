package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = "/assets/player.png")]
		private static var player:Class;
		
		public function Player() 
		{
			super(FlxG.width / 2, 233);
			scale.x *= -1;
			loadGraphic(player, true, false, 60, 80);
			addAnimation("gwalk", [0, 0, 1, 1, 2, 2, 3, 3], 15, true);
			addAnimation("bwalk", [4, 4, 5, 5], 7, true);
			play("bwalk");
		}
		
	}

}