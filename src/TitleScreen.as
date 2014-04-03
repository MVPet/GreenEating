package  
{
	import org.flixel.*;
	
	public class TitleScreen extends FlxState
	{
		[Embed(source = "/assets/Title.mp3")]
		private static var tMusic:Class;
		
		
		override public function create():void {
			var title:FlxText = new FlxText(100, 200, 500, "Press Play to Begin");
			title.setFormat(null, 12);
			var directions:FlxText = new FlxText(100, 50, 500, "Scientists are trying to get you to fall for designer foods. Don't let them.");
			directions.setFormat(null, 12);
			var direct2:FlxText = new FlxText(100, 100, 500,  "Answer questions correct quickly to avoid giving in.");
			direct2.setFormat(null, 12);
			var direct3:FlxText = new FlxText(100, 150, 500, "But be careful, if you run out of questions, you lose.");
			direct3.setFormat(null, 12);
			
			var start_button:FlxButton = new FlxButton(100, 250, "Play", StartGame);
			
			FlxG.mouse.show();
			FlxG.playMusic(tMusic);
			add(title);
			add(directions);
			add(direct2);
			add(direct3);
			add(start_button);
		}
		
		public function StartGame():void {
			
			FlxG.switchState(new GameManager);
		}		
	}

}