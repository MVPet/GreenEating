package  
{
	/**
	 * ...
	 * @author M
	 */
	public class QuizManager 
	{
		//holds the questions
		var questions:Array = new Array();
		
		//constructor
		public function QuizManager() {}
		
		//creates a question into an array and returns that array
		//format is question, answer1, answer2
		//ans1 and ans2 start if it is correct/false
		private function CreateQuestion(question:String, ans1:String, ans2:String):Array {
			var Question:Array = new Array(question, ans1, ans2);
			return Question;
		}
		
		//gets the array of questions
		public function getQuestions():Array {
			return questions;
		}
		
		public function AddQuestion(q:String, a1:String, a2:String):void {
			questions.push(CreateQuestion(q, a1, a2));
		}
		
		public function RemoveQuestion(num:Number) {
			questions.splice(num, 1);			
		}
	}

}