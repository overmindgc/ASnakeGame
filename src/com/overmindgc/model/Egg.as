package com.overmindgc.model
{
	import com.overmindgc.utils.Consts;
	
	import flash.display.Sprite;

	public class Egg extends Sprite
	{
		public function Egg()
		{
			this.graphics.beginFill(0x00ff00);
			this.graphics.drawCircle(Consts.paneWidth / 2, Consts.paneWidth / 2, Consts.paneWidth/2);
		}
		
		public function changeColor():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x0000ff);
			this.graphics.drawCircle(Consts.paneWidth / 2, Consts.paneWidth / 2, Consts.paneWidth/2);
//			this.graphics.drawCircle(Consts.paneWidth / 2, Consts.paneWidth / 2, Consts.paneWidth/2);
		}
	}
}