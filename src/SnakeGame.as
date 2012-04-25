package
{
	import com.overmindgc.model.Board;
	import com.overmindgc.model.Egg;
	import com.overmindgc.model.Snake;
	import com.overmindgc.utils.Consts;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	
	public class SnakeGame extends Sprite
	{
		public static const STATE_INIT:int = 10;
		public static const STATE_PLAY:int = 20;
		public static const STETE_GAMEOVER:int = 30;
		
		public var gameState:int = 0;
		
		public var scoreNum:int = 0;
		
		public var speed:int = 10;
		//1:上 2:下 3:左 4:右
		public var direction:int = 4;
		
		public var board:Board = new Board();
		
		public var scoreText:TextField = new TextField;
		public var gameOverText:TextField = new TextField();
		
		public var snakeNodeArr:Array = [];
		public var egg:Egg = new Egg();
		
		public var timer:Timer = new Timer(100);
		
		public function SnakeGame()
		{
			addChild(board);
//			board.x = stage.stageWidth / 2 - board.width / 2;
//			board.y = stage.stageHeight / 2 - board.height / 2;
			
			scoreText.text = "得分：";
			scoreText.x = board.x + board.w + 10;
			scoreText.y = board.y;
			addChild(scoreText);
			
			gameOverText.text = "Game Over!";
			gameOverText.x = Consts.boardWidth / 2 - gameOverText.width / 2;
			gameOverText.y = Consts.boardHeight / 2 - gameOverText.height /2;
			gameOverText.visible = false;
			var tf:TextFormat = new TextFormat();
			tf.size = 20;
			gameOverText.setTextFormat(tf);
			addChild(gameOverText);
			
			gameState = STATE_INIT;
			
			addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			timer.addEventListener(TimerEvent.TIMER,move);
		}
		
		public function gameLoop(event:Event):void
		{
			switch(gameState)
			{
				case STATE_INIT:
				{
					initGame();
					break;
				}
				case STATE_PLAY:
				{
					playGame();
					break;
				}
				case STETE_GAMEOVER:
				{
					gameOver();
					break;
				}
			}
		}
		
		public function initGame():void
		{
			var snakeHead:Snake = new Snake();
			snakeNodeArr.push(snakeHead);
			addChild(snakeHead);
			
			addChild(egg);
			randomEgg();
			
			scoreNum = 0;
			scoreText.text = "得分：" + scoreNum;
			
			gameState = STATE_PLAY;
			
			timer.start();
		}
		
		public function playGame():void
		{
			testCollisions();
		}
		
		public function gameOver():void
		{
//			removeEventListener(Event.ENTER_FRAME,gameLoop);
			
			if(timer.running)
			{
				timer.stop();
			}
			
			if(snakeNodeArr.length > 1)
			{
				removeChild(snakeNodeArr.pop());
			}
			
//			snakeNodeArr[0].x = 0;
//			snakeNodeArr[0].y = 0;
			
			gameOverText.visible = true;
		}
		
		public function testCollisions():void
		{
			var headSnake:Snake = Snake(snakeNodeArr[0]);
			if(headSnake.hitTestObject(egg))
			{
				var childNode:Egg = new Egg();
				childNode.changeColor();
				switch(direction)
				{
					case 1:
					{
						childNode.x = snakeNodeArr[snakeNodeArr.length - 1].x;
						childNode.y = snakeNodeArr[snakeNodeArr.length - 1].y + Consts.paneWidth;
						break;
					}
					case 2:
					{
						childNode.x = snakeNodeArr[snakeNodeArr.length - 1].x;
						childNode.y = snakeNodeArr[snakeNodeArr.length - 1].y - Consts.paneWidth*snakeNodeArr.length;
						break;
					}
					case 3:
					{
						childNode.x = snakeNodeArr[snakeNodeArr.length - 1].x + Consts.paneWidth*snakeNodeArr.length;
						childNode.y = snakeNodeArr[snakeNodeArr.length - 1].y;
						break;
					}
					case 4:
					{
						childNode.x = snakeNodeArr[snakeNodeArr.length - 1].x - Consts.paneWidth*snakeNodeArr.length;
						childNode.y = snakeNodeArr[snakeNodeArr.length - 1].y;
						break;
					}
				}
				snakeNodeArr.push(childNode);
				addChild(childNode);
				
				scoreNum++;
				scoreText.text = "得分：" + scoreNum;
				randomEgg();
			}
		}
		
		private function randomEgg():void
		{
			//随机1-20的整数，然后乘以方格宽度，减去半径(中心点是0,0)
//			egg.x = ((Math.round(Math.random() * 19)) + 1) * Consts.paneWidth - Consts.paneWidth / 2;
//			egg.y = ((Math.round(Math.random() * 19)) + 1) * Consts.paneWidth - Consts.paneWidth / 2;
			
			//随机0-19的整数，然后乘以方格宽度(中心点在左上角)
			egg.x = (Math.round(Math.random() * 19)) * Consts.paneWidth;
			egg.y = (Math.round(Math.random() * 19)) * Consts.paneWidth;
		}
		
		//1:上 2:下 3:左 4:右
		private function move(event:TimerEvent):void
		{
			var lastX:Number = 0;
			var lastY:Number = 0;
			
			var tempLastX:Number = 0;
			var tempLastY:Number = 0;
			
			for(var i:int=0; i<snakeNodeArr.length; i++)
			{
				var headX:Number = snakeNodeArr[0].x;
				var headY:Number = snakeNodeArr[0].y;
				if(headX < 0 || headY < 0 || headX > (Consts.boardWidth - Consts.paneWidth) || headY > (Consts.boardHeight - Consts.paneWidth))
				{
					gameState = STETE_GAMEOVER;
				} else
				{
					tempLastX = lastX;
					tempLastY = lastY;
					
					lastX = snakeNodeArr[i].x;
					lastY = snakeNodeArr[i].y;
					
					switch(direction)
					{
						case 1:
						{
							if(i == 0)
							{
								snakeNodeArr[i].y = snakeNodeArr[i].y - speed;
							} else
							{
								snakeNodeArr[i].x = tempLastX;
								snakeNodeArr[i].y = tempLastY;
							}
							break;
						}
						case 2:
						{
							if(i == 0)
							{
								snakeNodeArr[i].y = snakeNodeArr[i].y + speed;
							} else
							{
								snakeNodeArr[i].x = tempLastX;
								snakeNodeArr[i].y = tempLastY;
							}
							
							break;
						}
						case 3:
						{
							if(i == 0)
							{
								snakeNodeArr[i].x = snakeNodeArr[i].x - speed;
							} else
							{
								snakeNodeArr[i].x = tempLastX;
								snakeNodeArr[i].y = tempLastY;
							}
							
							break;
						}
						case 4:
						{
							if(i == 0)
							{
								snakeNodeArr[i].x = snakeNodeArr[i].x + speed;
							} else
							{
								snakeNodeArr[i].x = tempLastX;
								snakeNodeArr[i].y = tempLastY;
							}
							break;
						}
					}
				}
			}
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					if(direction != 2)
					{
						direction = 1;
					}
					break;
				case Keyboard.DOWN:
					if(direction != 1)
					{
						direction = 2;
					}
					break;
				case Keyboard.LEFT:
					if(direction != 4)
					{
						direction = 3;
					}
					break;
				case Keyboard.RIGHT:
					if(direction != 3)
					{
						direction = 4;
					}
					break;
			}
		}
	}
}