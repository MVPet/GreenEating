package  
{
		
	import org.flixel.*;
	
	public class GameManager extends FlxState
	{
		[Embed(source = "/assets/top_screen.png")]
		private static var tScreen:Class;
		
		[Embed(source = "/assets/back_window.png")]
		private static var bGround:Class;
		
		[Embed(source = "/assets/buttons.png")]
		private static var button:Class;
		
		[Embed(source = "/assets/caps.png")]
		private static var caps:Class;
		
		[Embed(source = "/assets/Play.mp3")]
		private static var pMusic:Class;
		
		var qManager:QuizManager = new QuizManager();
		
		//temp player and enemy
		var player:Player = new Player();
		var emitter:FlxEmitter;
		
		var bCapsule:FlxSprite = new FlxSprite().loadGraphic(caps, false, false, 80, 150);
		var gCapsule:FlxSprite = new FlxSprite().loadGraphic(caps, false, false, 80, 150);
		
		//handles the "two screens"
		//var top_screen:FlxSprite = new FlxSprite().loadGraphic(tScreen, false, false, 640, 320);
		var top_screen:FlxSprite = new FlxSprite().loadGraphic(tScreen, false, false, 640, 320);
		var background:FlxSprite = new FlxSprite().loadGraphic(bGround, false, false, 362, 119);
		var bottom_screen:FlxSprite = new FlxSprite().makeGraphic(640, 160, 0x66666666);
		
		//holds the question and answers string, also the feedback
		var question:String;
		var answer1:String;
		var answer2:String;
		var feedback:String;
		
		//uses this for Flixel stuff
		var flx_question:FlxText;
		var flx_answer1:FlxButton;
		var flx_answer2:FlxButton;
		var flx_feedback:FlxText;
		
		var remainQuestions:Number;
		var questionsLeft:FlxText;
		
		var scientists:Vector.<Scientist>;
		
		var random:Number;
		var timer:Number = 0;
		var input_allowed:Boolean = true;
		var counter:Number = 0;		
		
		override public function update():void {
			
			timer += 1
			
			super.update();
			emitter.x = player.x + (player.width / 2);
			emitter.y = player.y + (player.height / 2);
			
			if (input_allowed) {
			
				if (timer >= 2)
				{
					player.x -= 0.5;
					timer = 0;
				}
			
				if (player.x <= (bCapsule.x + bCapsule.width))
					FlxG.switchState(new LoseScreen);
				else if ((player.x + player.width) >= gCapsule.x)
					FlxG.switchState(new WinScreen);
			} else {
				
				if (timer >= 2)
				{
					player.x += 2;
					counter += 2;
					timer = 0;
				}
				
				if (counter >= 70) {
					AlterInput(true);
					player.scale.x *= -1;
					player.play("bwalk");
					counter = 0;
				}
			}				
		}
		
		//This is what loads upon the creating/switching of States
		override public function create():void {
			GenerateQuestions();
			SetUpGame();
		}
		
		private function SetUpGame():void {
			//show the Flixel mouse cursor
			FlxG.mouse.show();
			FlxG.playMusic(pMusic);
			
			top_screen.x = 0;
			top_screen.y = 0;
			
			background.x = 146;
			background.y = 77;
			
			bCapsule.y = 175;
			bCapsule.x = 30;
			
			gCapsule.y = 175;
			gCapsule.x = 530;
		
			bottom_screen.x = 0;
			bottom_screen.y = 320;
		

			
			//converst the question into Flixel objects
			flx_question = new FlxText(200, 320, 200);
			flx_question.scale = new FlxPoint(2, 2);
			//upon button click will check if that answer is correct
			//cuts off the first letter since it is if it is correct or not
			flx_answer1 = new FlxButton(0, 380, "", CheckAnswer1);
			flx_answer1.loadGraphic(button, true, false, 320, 100);
			flx_answer1.labelOffset = new FlxPoint( 10, 30);
			flx_answer1.label.setFormat(null,12,0x333333,"left");
			flx_answer2 = new FlxButton(320, 380, "", CheckAnswer2);
			flx_answer2.loadGraphic(button, true, false, 320, 100);
			flx_answer2.labelOffset = new FlxPoint( 10, 30);
			flx_answer2.label.setFormat(null,12,0x333333,"left");
			flx_answer2.loadGraphic(button, false, false)
			
			flx_feedback = new FlxText(30, 320, 200);
			flx_feedback.scale = new FlxPoint(2, 2);
			
			questionsLeft = new FlxText(590, 320, 70);
			questionsLeft.scale = new FlxPoint(2, 2);
			remainQuestions = qManager.questions.length;
			questionsLeft.text = "?'s left:\n     " + remainQuestions.toString();
			
			NextQuestion();
			
			//adds them to the application
			add(background);
			MakeScientists();
			
			add(top_screen);			
			
			add(bCapsule);
			add(gCapsule);
			RandomizeFood();		
			
			LoadEmitter();
			add(player);
			
			add(bottom_screen);
			add(flx_question);
			add(flx_answer1);
			add(flx_answer2);
			add(flx_feedback);
			add(questionsLeft);
		}
		
		private function GenerateQuestions():void {
			qManager.AddQuestion("You find yourself mindlessly munching on chips while studying. You should...", "fKeep a big bag next to you so you don't run out", "tBring a single serving of chips for a snack");
			qManager.AddQuestion("You find your favorite ice cream in the freezer. You should...", "tClose the freezer and find a healthier snack", "fMake a big sundae and eat until you're stuffed");
			qManager.AddQuestion("You want a snack with your coffee. You choose...", "fA donut", "tA whole wheat bagel");
			qManager.AddQuestion("You're always hungry driving home from work. You...", "tWait to prepare a healthy meal at home to eat", "fEat an entire sleeve");
			qManager.AddQuestion("You want to eat cookies. You...", "fEat an entire sleeve", "tTake out one serving and that's it!");
			qManager.AddQuestion("You stop for coffee on your way to class. You should order...", "tA black coffee with no sugar", "fA large \"extra-extra\"");
			qManager.AddQuestion("At the movies, you order...", "fA buttered popcorn and a soda", "tAn unbuttered popcorn and a water");
			qManager.AddQuestion("You're looking forward to a sweet evening snack of...", "tA yogurt parfait and tea", "fCookies and Hot Chocolate");
			qManager.AddQuestion("At a restaurant, you choose a side of...", "fFrench Fries", "tA house salad");
			qManager.AddQuestion("The portion sizes are huge at this resteraunt! You should...", "tWrap half up for tomorrow's lunch", "fEat it all");
			qManager.AddQuestion("You are feeling stressed, so you...", "tGo for a walk to clear your head", "fGrab some candy to feel better");
			qManager.AddQuestion("You're sleepy during class, so you drink...", "tA black tea", "fA sugary energy drink");
			qManager.AddQuestion("Breakfast on the go consists of...", "tFruit and nut trail mix", "fA pastry");
			qManager.AddQuestion("You're at the pizza shop, you order...", "fThe five meat pizza", "tA salad with beans");
			qManager.AddQuestion("For a quick dinner you whip up...", "tWhole grain pasta with frozen veggies", "fA hot dog");
			qManager.AddQuestion("For an in-between-snack snack, you pack...", "tAn apple", "fA bag of chips");
			qManager.AddQuestion("You're looking for a celebratory treat. You...", "fBuy an ice-cream cake", "tTreat yourself to an activity like rock-climbing or a yoga class");
			qManager.AddQuestion("During exams, you feel stressed. Find relief by...", "tStudying at the library with friends", "fEating processed sweets and snacks");
			qManager.AddQuestion("When bored, you entertain yourself by...", "fHeading to the kitchen for a snack", "tGoing for a run");
			qManager.AddQuestion("The smell of baked goods from the kitchen entices you, but you are not hungry. You...", "tDistract yourself with a book and wait until you are hungry to eat", "fEat the baked goods anyway");
			qManager.AddQuestion("You snacked a lot without satisfaction. To try and feel satiated, you...", "tHave a glass of water because if may be thirst you are feeling", "fKeep Eating");
			qManager.AddQuestion("You're tempted to grab a snack before you start your homework, even though you aren't hungry. You...", "fEat some candy before you begin, you know, for energy", "tRecognize that you might be procastinating and get to work!");
			qManager.AddQuestion("When you're sad, you...", "tWrite in a journal or confess to a friend", "fTurn to food for comfort");
			qManager.AddQuestion("You're in a fight with your friend so you...", "fAvoid your feelings by getting full on unhealthy treats", "tShare your troubles with a confidant and try to solve the problem");
			qManager.AddQuestion("You want a quick and easy breakfast to eat in your dorm room. You stock up on...", "tPlan instant oatmeal and raisins", "fBagels and Cream Cheese");
			qManager.AddQuestion("When shopping for snacks for your apartment, you presue the...", "tThe produce section!", "fChip and cookie aisles");
			qManager.AddQuestion("Your friends are eating processed snacks around you. You feel like a snack of you...", "fJoin them", "tGet your own healthy snack");
			qManager.AddQuestion("You find yourself hungry during the day with no healthy snack around. Tomorrow you...", "tPack a healthy snack and lunch", "fHope you remember change for the vending machine");
			qManager.AddQuestion("After finding limited supplies in the kitchen for dinner, you...", "fCall up the pizza delivery guy", "tHead to the grocery store with a list and plan to make enough for dinner and leftovers");
			qManager.AddQuestion("It's lunchtime on campus. Time to...", "tUnpack your reusable lunch bag filled with a healthy lunch you packed last night", "fGet Chinese!");
		}
		
		private function NextQuestion():void {
			
			if (qManager.getQuestions().length == 0)
				FlxG.switchState(new LoseScreen);
			
			random = Math.floor(Math.random() * (qManager.getQuestions().length));
			
			if (qManager.getQuestions().length === 0) {
				question = "";
				answer1 = "";
				answer2 = "";
			} else {
				//gets the question and answers
				question = qManager.getQuestions()[random][0];
				answer1 = qManager.getQuestions()[random][1];
				answer2 = qManager.getQuestions()[random][2];
			}
			
			flx_question.text = question;
			flx_answer1.label = new FlxText(0, 0, 300, answer1.substr(1, answer1.length - 1));
			flx_answer1.label.setFormat(null,12,0x333333,"left");
			flx_answer2.label = new FlxText(0, 0, 300, answer2.substr(1, answer2.length - 1));
			flx_answer2.label.setFormat(null, 12, 0x333333, "left");
			flx_feedback.text == "";
		}
		
		//checks if answer 1 is correct
		private function CheckAnswer1():void {
			if (input_allowed)
			{
				if (answer1.substr(0, 1) === "t") {
					flx_feedback.text = "You're Right!";
					player.scale.x *= -1;
					emitter.start(false, 0.75, 0.05, 20);
					//FlxG.flash(0x0000ff00, 0.25);
					AlterInput(false);
				} else {
					flx_feedback.text = "You're Wrong!";
					FlxG.shake(0.05, 0.5);
				}
				qManager.RemoveQuestion(random);
				remainQuestions--;
				NextQuestion();
				questionsLeft.text = "?'s left:\n     " + remainQuestions.toString();
			}
		}
		
		//checks if Question 2 is correct
		private function CheckAnswer2():void {
			if (input_allowed)
			{
				if (answer2.substr(0, 1) === "t") {
					flx_feedback.text = "You're Right!";
					emitter.start(false, 0.75, 0.05, 20);
					//FlxG.flash(0x0000ff00, 0.25);
					AlterInput(false);
					player.scale.x *= -1;
				} else {
					flx_feedback.text = "You're Wrong!";
					FlxG.shake(0.05, 0.5);
				}
				qManager.RemoveQuestion(random);
				remainQuestions--;
				NextQuestion();
				questionsLeft.text = "?'s left:\n     " + remainQuestions.toString();
			}
		}
		
		public function AlterInput(a:Boolean):void {
			player.play("gwalk");
			input_allowed = a;
		}
		
		public function RandomizeFood():void {
			
			var random_x:Number;
			var random_y:Number;
							
			
			for (var i:Number = 0; i <= 10; i++) {
				
				random_x = Math.floor(Math.random() * 20);
				random_y = Math.floor(Math.random() * 75);
			
				add(new BadFood( (37 + random_x), (190 + random_y)));
			}
			
			for (var i:Number = 0; i <= 10; i++) {
				
				random_x = Math.floor(Math.random() * 20);
				random_y = Math.floor(Math.random() * 75);
			
				add(new Food((537 + random_x), (190 + random_y)));
			}
		}
		
		public function MakeScientists():void {
			scientists = new Vector.<Scientist>();
			for (var i:Number = 0; i <= 7; i++) {
				scientists.push(new Scientist(100));
				add(scientists[i]);
			}
			
		}
		
		public function LoadEmitter():void {
			/*emitter = new FlxEmitter(player.x, player.y, 1000);
			emitter.gravity = 350;
			emitter.setRotation(0, 0);
			emitter.setXSpeed( -160, 160);
			emitter.setYSpeed( -200, -300);
			for (var i:int = 0; i < 300; i++) {
				emitter.add(new Particle(false));
			}*/
			
			emitter = new FlxEmitter(100,100); //x and y of the emitter
			var particles:int = 300;
 
			for(var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(5, 5, 0xff00f225);
				particle.exists = false;
				emitter.add(particle);
			}
	
			add(emitter);
		}
	}
}