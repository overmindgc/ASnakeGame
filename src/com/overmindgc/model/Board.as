package com.overmindgc.model
{
	import com.overmindgc.utils.Consts;
	
	import flash.display.Sprite;
	
	public class Board extends Sprite
	{
		public var w:Number = Consts.boardWidth;
		public var h:Number = Consts.boardHeight;
		
		public var xNum:int = Consts.xNum;
		public var yNum:int = Consts.yNum;
		public var paneW:Number = Consts.paneWidth;
		
		public function Board()
		{
			//画边框（粗线）
			this.graphics.lineStyle(1, 0x000000);
			this.graphics.lineTo(xNum * paneW , 0);
			this.graphics.lineTo(xNum * paneW ,yNum * paneW);
			this.graphics.lineTo(0, yNum * paneW );
			this.graphics.lineTo(0,0);
			this.graphics.lineStyle();
			
			//画垂直和水平方向的线条
			this.graphics.lineStyle(1, 0x000000, 0.5);
			for (var i:int = 0; i < xNum-1;i++ ) {
				this.graphics.moveTo(paneW * (i + 1), 0);
				this.graphics.lineTo(paneW * (i + 1), paneW*yNum);
			}
			for (i = 0; i < yNum-1;i++ ) {
				this.graphics.moveTo(0, paneW*(i+1));
				this.graphics.lineTo(paneW * xNum , paneW*(i+1));
			}
		}
	}
}