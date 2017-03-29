package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.IVisualElementContainer;
	
	/**
	 * 爆炸效果
	 */
	public class CardBombEffect extends CustomEffectBase
	{
		public var row:int = 23;
		public var col:int = 17;
		public var target:Sprite;
		
		private  var effectContainer:UIAsset;

		protected var bombFrame:int = 6;
		protected var retractFrame:int = 0;
		protected var totalFrame:int;
		private var targetBitmapdata:BitmapData;
		private var effectBitmapdata:BitmapData;
		private var addToWindow:IVisualElementContainer;
		private var piecesLogicArray:Vector.<Vector.<CardBombEffectItem>>;
		private var pieceWidth:int;
		private var pieceHeight:int;
		private var bombInitSpeed:Number = 10;
		private var effectExpandSize:int = 200;
		private var passFrame:int;
		private var xFrom:Number;
		private var yFrom:Number;
		private var xChange:Number;
		private var yChange:Number;
		private var xOriginal:Number;
		private var yOriginal:Number;
		
		public function CardBombEffect(target:Sprite , xFrom:Number , yFrom:Number , xChange:Number = 0 , yChange:Number = 0)
		{
			super();
			this.totalFrame = this.bombFrame + this.retractFrame;
			this.target = target;
			this.xFrom = xFrom;
			this.yFrom = yFrom;
			this.xChange = xChange;
			this.yChange = yChange;
			this.pieceWidth = Math.ceil(target.width / this.col);
			this.pieceHeight = Math.ceil(target.height / this.row);
			this.effectBitmapdata = new BitmapData(target.width + this.effectExpandSize * 2, target.height + this.effectExpandSize * 2, true, 0);
			var bitmap:Bitmap = new Bitmap(effectBitmapdata , "auto" , true);
			bitmap.x = -effectBitmapdata.width/2;
			bitmap.y = -effectBitmapdata.height/2;
			effectContainer = new UIAsset();
			this.effectContainer.skinName = bitmap;
		}
		
		override public function play() : void
		{
			addToWindow = this.target.parent as IVisualElementContainer;
			this.buildSource();
			this.passFrame = 0;
			this.xOriginal = this.xFrom;
			this.effectContainer.x = xOriginal;
			this.yOriginal = this.yFrom;
			this.effectContainer.y = yOriginal;
			addToWindow.addElement(this.effectContainer);
			super.play();
		}
		
		override public function end() : void
		{
			if (this.effectContainer.parent)
			{
				(this.effectContainer.parent as IVisualElementContainer).removeElement(this.effectContainer);
			}
			super.end();
		}
		
		public function buildSource() : void
		{
			this.targetBitmapdata = new BitmapData(this.target.width, this.target.height, true, 0);
			this.targetBitmapdata.draw(this.target,new Matrix(this.target.scaleX,0,0,this.target.scaleY,this.target.width/2, this.target.height/2));
			if (this.piecesLogicArray)
			{
				for each (var piecesLogics:Array in this.piecesLogicArray)
				{
					for each (var piecesLogic:CardBombEffectItem in piecesLogics)
					{
						
						piecesLogic.restore();
					}
				}
			}
			else
			{
				var currentRow:int = 0;
				var rowPiece:Vector.<CardBombEffectItem>;
				this.piecesLogicArray = new Vector.<Vector.<CardBombEffectItem>>(this.row);
				while (currentRow < this.row)
				{
					rowPiece = new Vector.<CardBombEffectItem>(this.col);
					var currentCol:int = 0;
					while (currentCol < this.col)
					{
						rowPiece[currentCol] = new CardBombEffectItem(this.effectExpandSize + this.pieceWidth * currentCol, this.effectExpandSize + this.pieceHeight * currentRow, this.bombInitSpeed);
						currentCol++;
					}
					this.piecesLogicArray[currentRow] = rowPiece;
					currentRow++;
				}
			}
		}
		
		override protected function enterFrameHandler(event:Event) : void
		{
			if (this.passFrame == this.totalFrame)
			{
				this.end();
				return;
			}
			if (this.passFrame > this.bombFrame)
			{
				var percent:Number = this.easeOut(this.totalFrame - this.passFrame, this.retractFrame);
				this.effectContainer.x = this.xOriginal + this.xChange * percent;
				this.effectContainer.y = this.yOriginal + this.yChange * percent;
			}
			else if (this.passFrame == this.bombFrame)
			{
				var currentRow:int = 0;
				var rowPiece:Vector.<CardBombEffectItem>;
				while (currentRow < this.row)
				{
					rowPiece = this.piecesLogicArray[currentRow] as Vector.<CardBombEffectItem>;
					var currentCol:int = 0;
					while (currentCol < this.col)
					{
						
						this.changeItemFlySpeed(rowPiece[currentCol], this.row + this.col - currentRow - currentCol);
						currentCol++;
					}
					currentRow++;
				}
			}
			this.changeAlpha(this.passFrame, this.totalFrame);
			this.drawEffectBitMapData();
			this.passFrame ++;
		}
		private var flag:Boolean;
		
		protected function changeItemFlySpeed(item:CardBombEffectItem, param2:int) : void
		{
			var _loc_3:* = this.retractFrame - param2 / 3;
			var _loc_4:* = 2 / (_loc_3 * _loc_3);
			item.xSpeedArg = (item.originalX - item.x - item.vx * _loc_3) * _loc_4;
			item.ySpeedArg = (item.originalY - item.y - item.vy * _loc_3) * _loc_4;
		}
		
		protected function drawEffectBitMapData() : void
		{
			this.effectBitmapdata.lock();
			this.effectBitmapdata.fillRect(new Rectangle(0, 0, this.effectBitmapdata.width, this.effectBitmapdata.height), 0);
			var currentRow:int = 0;
			var rowPiece:Vector.<CardBombEffectItem>;
			while (currentRow < this.row)
			{
				rowPiece = this.piecesLogicArray[currentRow] as Vector.<CardBombEffectItem>;
				var currentCol:int = 0;
				while (currentCol < this.col)
				{
					var item:CardBombEffectItem = rowPiece[currentCol];
					item.update();
					this.effectBitmapdata.copyPixels(this.targetBitmapdata,
						new Rectangle(currentCol * this.pieceWidth, currentRow * this.pieceHeight, this.pieceWidth, this.pieceHeight), 
						new Point(item.x, item.y));
					currentCol++;
				}
				currentRow++;
			}
			this.effectBitmapdata.unlock();
		}
		
//		public function attach(parent:Sprite) : void
//		{
//			this.addToWindow = parent;
//		}
		
		protected function changeAlpha(num1:int, num2:int) : void
		{
//	        if (num1 < num2 / 2)
//	        {
//				this.effectContainer.alpha = this.easeOut(num1, num2);
//            }
//            else
//            {
//                this.effectContainer.alpha = this.easeOut(num2 - num1, num2);
//            }
			this.effectContainer.alpha = 1-num1/num2;
		}
		
		protected function easeOut(num1:Number, num2:Number) : Number
		{
			return (1-num1/num2)*(1-num1/num2);
		}
	}
}