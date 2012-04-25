package com.overmindgc.model
{
	import com.overmindgc.utils.Consts;
	
	import flash.display.Sprite;
	
	public class Snake extends Sprite
	{
		public function Snake()
		{
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0, 0, Consts.paneWidth, Consts.paneWidth);
		}
	}
}