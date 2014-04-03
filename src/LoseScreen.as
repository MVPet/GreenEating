package  
{
	import org.flixel.*;
	
	public class LoseScreen extends FlxState
	{
		[Embed(source = "/assets/LoseSong.mp3")]
		private static var tMusic:Class;
		
		var title:FlxText;
		var start_button:FlxButton;
		var rightEmitter:FlxEmitter;
		var leftEmitter:FlxEmitter;
		
		override public function create():void {
			
			title = new FlxText(425, 100, 500, "You lose, press play to try again");
			title.scale = new FlxPoint(2, 2);
			start_button = new FlxButton(300, 150, "Play", StartGame);
			
			FlxG.mouse.show();
			FlxG.playMusic(tMusic);
			DisplayStuff();
			add(title);
			add(start_button);
		}
		
		public function DisplayStuff():void {
			for (var a:Number = 0; a <= 7; a++) {
				var science = new Scientist(200);
				add(science);
			}
			
			var player:Player = new Player();
			player.play("bwalk");
			add(player);
			
			rightEmitter = new FlxEmitter(500, -30, 1000);
			rightEmitter.gravity = 350;
			rightEmitter.setRotation(0, 0);
			rightEmitter.setXSpeed( -160, 160);
			rightEmitter.setYSpeed( -200, -300);
			
			leftEmitter = new FlxEmitter(200, -30, 1000);
			leftEmitter.gravity = 350;
			leftEmitter.setRotation(0, 0);
			leftEmitter.setXSpeed( -160, 160);
			leftEmitter.setYSpeed( -200, -300);
			
			for (var i:int = 0; i < rightEmitter.maxSize; i++) 
			{
				rightEmitter.add(new FoodParticle(true));
				leftEmitter.add(new FoodParticle(true));
			}
			
			add(rightEmitter);
			add(leftEmitter);
			leftEmitter.start(false, 5, 0.1, 1000);
			rightEmitter.start(false, 5, 0.1, 1000);
		}
		
		public function StartGame():void {
			
			FlxG.switchState(new GameManager);
		}		
	}

}