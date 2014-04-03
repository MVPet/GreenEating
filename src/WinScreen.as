package  
{
	import org.flixel.*;
	
	//NOTE MAKE EMITTER SHOOT OUT FOOD PARTICLES NEXT TO THE PLAYER
	//NEED TO MAKE OWN BUTTONS
	
	public class WinScreen extends FlxState
	{
		[Embed(source = "/assets/VictorySong.mp3")]
		private static var winrar:Class;
		
		var title:FlxText;
		var start_button:FlxButton;
		var rightEmitter:FlxEmitter;
		var leftEmitter:FlxEmitter;
		
		override public function create():void {
			
			title = new FlxText(425, 100, 500, "You win, press play to try again");
			title.scale = new FlxPoint(2, 2);
			start_button = new FlxButton(300, 150, "Play", StartGame);
			
			
			FlxG.mouse.show();
			FlxG.playMusic(winrar);
			DisplayStuff();
			add(title);
			add(start_button);
		}
		
		public function DisplayStuff() {
			var player:Player = new Player();
			player.play("gwalk");
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
				rightEmitter.add(new FoodParticle(false));
				leftEmitter.add(new FoodParticle(false));
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