package com.syndrome.sanguo.battle.combat_ui.card
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.EffectGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Effect3DCantainer;
	import com.syndrome.sanguo.battle.effect.CardBombEffect;
	import com.syndrome.sanguo.battle.effect.MoveEffect;
	import com.syndrome.sanguo.battle.effect.RotateEffect;
	import com.syndrome.sanguo.battle.effect.RotateY3DEffect;
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectEvent;
	import com.syndrome.sanguo.battle.effect.swfeffect.SwfEffectBase;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	import com.syndrome.sanguo.battle.skin.AttackIconSkin;
	import com.syndrome.sanguo.battle.skin.DefenseIconSkin;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import manger.SoundManager;
	
	import org.flexlite.domDll.Dll;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	
	import utils.MatrixUtil;
	import utils.Tween;

	/**
	 * 战场的卡片
	 */
	public class GameCard extends Group
	{
		private var _cardImage:CardImage;
		/**
		 * 卡片信息
		 * 字段有 me id address isAttack isPositive isSelected isSelectable slotType  base等
		 */
		public var cardInfo:Object;
		
		/**
		 * 卡片的所有者
		 */
		public var isMe:Boolean;
		
		private var selectState:Boolean = false;
		private var isMoving:Boolean = false;
		
		public function GameCard()
		{
			super();
			cardImage = new CardImage();
			this.width = CardConst.width;
			this.height = CardConst.height;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			cardImage.addEventListener(MouseEvent.ROLL_OVER, mouseOverCardHandler);
			cardImage.addEventListener(MouseEvent.ROLL_OUT, mouseOutCardHandler);
			cardImage.addEventListener(MouseEvent.CLICK, clickCardHandler);
			cardImage.x = -this.width/2;
			cardImage.y = -this.height/2;
			this.addElement(cardImage);
			
			//卡牌边框
			var border:UIAsset = new UIAsset();
			border.mouseChildren = false;
			border.mouseEnabled = false;
			border.x = cardImage.x;
			border.y = cardImage.y;
			border.width = this.width;
			border.height = this.height;
			border.skinName = "IMG_Card_border";
			this.addElement(border);
		}
		
		/**
		 * 显示回合计数标记
		 */
		public function showCardRoundCount(value:int):void
		{
			this.cardImage.showCardRoundCount(value);
		}
		
		/**
		 * 移除回合计数标记
		 */
		public function hideCardRoundCount():void
		{
			this.cardImage.hideCardRoundCount();
		}
		
		/**
		 * 添加阵型标记
		 */
		public function showPhalanxFlag():void
		{
			this.cardImage.showPhalanxFlag();
		}
		
		/**
		 * 移除阵型标记
		 */
		public function hidePhalanxFlag():void
		{
			this.cardImage.hidePhalanxFlag();
		}
		
		/**
		 * 播放墓地效果
		 */
		public function playGrave():void
		{
			var clazz:Class = Dll.getRes("Effect_Grave") as Class;
			var mc:MovieClip = new clazz() as MovieClip;
			var swfEffect:SwfEffectBase = new SwfEffectBase(mc);
			swfEffect.startPlay();
			this.addElementAt(swfEffect,0);
		}
		
		/**
		 * 播放效果发动
		 */
		public function playLaunch():void
		{
			var clazz:Class = Dll.getRes("Effect_Launch") as Class;
			var mc:MovieClip = new clazz() as MovieClip;
			var swfEffect:SwfEffectBase = new SwfEffectBase(mc);
			var point:Point = EffectGroup.getInstance().globalToLocal(this.localToGlobal(new Point(0,0)));
			swfEffect.x = point.x;
			swfEffect.y = point.y;
			swfEffect.startPlay();
			EffectGroup.getInstance().addElement(swfEffect);
		}
		
		private var battleGroupUI:BattleGroupUI;
		/**
		 * 添加战团显示
		 */
		public function addBattleGroupEffect(color:uint , isAttack:Boolean = false):void
		{
			if(!battleGroupUI){
				battleGroupUI = new BattleGroupUI();
				this.addElement(battleGroupUI);
			}
			if(isAttack){
				battleGroupUI.skinName = AttackIconSkin;
				battleGroupUI.scaleY = cardInfo["me"]?1:-1;
			}else{
				battleGroupUI.skinName = DefenseIconSkin;
				battleGroupUI.scaleY = 1;
			}
			battleGroupUI.horizontalCenter = -this.width/2;
			battleGroupUI.verticalCenter = -this.height/2;
			battleGroupUI.color = color;
		}
		
		/**
		 * 移除战团显示
		 */
		public function removeBattleGroupEffect():void
		{
			if(battleGroupUI){
				this.removeElement(battleGroupUI);
				battleGroupUI = null;
			}
		}
		
		public function isChainTarget(on:Boolean):void
		{
			this.cardImage.addChainTarget(on);
		}
		
		public function isChainSource(on:Boolean):void
		{
			this.cardImage.addChainSource(on);
		}
		
		/**
		 * 添加伤害显示
		 */
		public function addHurt(num:int) : void
		{
			this.cardImage.addHurt(num);
		}
		
		/**
		 * 移除伤害显示
		 */
		public function removeHurt(num:int = int.MAX_VALUE):void
		{
			this.cardImage.removeHurt(num);
		}
		
		/**
		 * 改变卡牌属性
		 */
		public function setAttribInfo(attack:int, health:int, intelligence:int, visible:Boolean = true) : void
		{
			this.cardImage.setAttribInfo(attack , health , intelligence, visible);
		}
		
		/**
		 * 设置卡牌信息
		 */
		public function setCardInfo(cardInfo:Object) : void
		{
			this.cardInfo = cardInfo;
			this.cardImage.refreshCardInfo(cardInfo , false , false);
			setImage();
		}
		
		/**
		 * 刷新
		 */
		public function refreshCardInfo():void
		{
			this.cardImage.refreshCardInfo(cardInfo);
			setImage();
		}
		
		/**
		 * 更新卡图显示
		 */
		public function setImage() : void
		{
			this.cardImage.isPositive = this.cardInfo["isPositive"];
			this.cardImage.isSelectable = this.cardInfo["isSelectable"];
			this.cardImage.isSelected = this.cardInfo["isSelected"];
		}
		
		/**
		 * 控制卡的正反 和 是否攻击  changeRelateCard是否改变关联卡的位置
		 */
		public function changePosition(toPositive:Boolean, toAttack:Boolean) : void
		{
			if (toAttack != this.cardInfo["isAttack"] || toPositive != this.cardInfo["isPositive"])
			{
				SoundManager.play("MP3_Overturn");
			}
			var endTimes:int = 0;
			
			if(cardInfo.hasOwnProperty("state") && cardInfo["state"] == CardConst.state_dead){
				this.cardInfo["isAttack"] = toAttack;
				this.cardInfo["isPositive"] = toPositive;
				return;
			}
			if (toAttack != this.cardInfo["isAttack"])
			{
				endTimes++;
				var rotationEffectEndHandle:Function = function(event:CustomEffectEvent):void
				{
					rotationEffect.removeEventListener(CustomEffectEvent.END , rotationEffectEndHandle);
					endTimes--;
					if(endTimes==0){
						dispatchEvent(new Event("changeComplete"));
					}
				}
				var rotationEffect:RotateEffect = new RotateEffect(this,this.rotation,toAttack?0:90,300);
				rotationEffect.play();
				rotationEffect.addEventListener(CustomEffectEvent.END , rotationEffectEndHandle);
			}
			if (toPositive != this.cardInfo["isPositive"])
			{
				endTimes++;
				var rotationYEffect:RotateY3DEffect;
				var effectEndhandler:Function;
				var This:GameCard = this;
				effectEndhandler = function (event:CustomEffectEvent) : void
				{
					rotationYEffect.removeEventListener(CustomEffectEvent.END, effectEndhandler);
					setImage();
					var effectEndhandler2:Function;
					effectEndhandler2 = function (event:CustomEffectEvent) : void
					{
						rotationYEffect2.removeEventListener(CustomEffectEvent.END, effectEndhandler2);
						if(This.cardInfo["slotType"] == CardSlotConst.handCardSlot){
							MatrixUtil.changeTo2D(This);
							MatrixUtil.changeTo2D(This.cardImage);
						}
						endTimes--;
						if(endTimes==0){
							dispatchEvent(new Event("changeComplete"));
						}
					}
					var rotationYEffect2:RotateY3DEffect = new RotateY3DEffect(This, -90, 0, 150);
					rotationYEffect2.addEventListener(CustomEffectEvent.END, effectEndhandler2);
					rotationYEffect2.play();
				};
				rotationYEffect = new RotateY3DEffect(This, 0, 90, 150);
				rotationYEffect.addEventListener(CustomEffectEvent.END, effectEndhandler);
				rotationYEffect.play();
			}
			this.cardInfo["isAttack"] = toAttack;
			this.cardInfo["isPositive"] = toPositive;
			if(endTimes==0){
				dispatchEvent(new Event("changeComplete"));
			}
		}
		
		private var _xPosition:Number;
		private var _yPosition:Number;
		private var moveEffect:MoveEffect;
		/**
		 * 移动卡牌
		 */
		public function startMove(xPosition:Number , yPosition:Number):void
		{
			if (isMoving && xPosition == this._xPosition && yPosition == this._yPosition || !isMoving && xPosition == this.x && yPosition == this.y)
			{
				dispatchEvent(new Event("moveArrived"));
				return;
			}
			this.isMoving = true;
			this._xPosition = xPosition;
			this._yPosition = yPosition;
			if(cardInfo.hasOwnProperty("state") && cardInfo["state"] == CardConst.state_dead){ //阵亡
				delete cardInfo["state"];
				playBomb(xPosition , yPosition);
			}else if(cardInfo.hasOwnProperty("state") && cardInfo["state"] == CardConst.state_break){  //破坏
				delete cardInfo["state"];
				playBomb2(xPosition , yPosition);
			}else{
				playMove(xPosition , yPosition);
			}
		}
		
		/**
		 * 破坏的效果
		 */
		private function playBomb2(xPosition:Number , yPosition:Number):void
		{
			SoundManager.play("MP3_Broken");
			var self:GameCard = this;
			var bombEndHandler:Function = function (event:CustomEffectEvent) : void
			{
				bombEffect.removeEventListener(CustomEffectEvent.END, bombEndHandler);
				visible = true;
				x = xPosition;
				y = yPosition;
				self.alpha = 0;
				self.setImage();
				self.rotation = self.cardInfo["isAttack"] ? (0) : (90);
				Tween.to(self , 300 , {alpha:1 , onComplete:moveArrived});
			};
			var bombEffect:CardBombEffect = new CardBombEffect(this, x, y ,0 , 0);
			bombEffect.play();
			bombEffect.addEventListener(CustomEffectEvent.END, bombEndHandler);
			this.visible = false;
		}
		
		/**
		 * 阵亡的效果
		 */
		public function playBomb(xPosition:Number , yPosition:Number):void
		{
			var self:GameCard = this;
			var point:Point = Effect3DCantainer.getInstance().globalToLocal(this.localToGlobal(new Point(0,0)));
			
			CombatConsole.getInstance().addActionList([2000, [function():void{
				Effect3DCantainer.getInstance().playDeadEffect(point , self , function():void{
					visible = true;
					x = xPosition;
					y = yPosition;
					alpha = 0;
					setImage();
					rotation = cardInfo["isAttack"] ? (0) : (90);
					Tween.to(self , 300 , {alpha:1 , onComplete:moveArrived});
				});
			}]]);
			
			
		}
		
		private function playMove(xPosition:Number , yPosition:Number):void
		{
			if(moveEffect == null){
				moveEffect = new MoveEffect(this,300);
			}
			moveEffect.addEventListener(CustomEffectEvent.END, this.moveArrived);
			moveEffect.xTo = xPosition;
			moveEffect.yTo = yPosition;
			moveEffect.play();
		}
		
		private function moveArrived(event:CustomEffectEvent = null) : void
		{
			if(moveEffect){
				moveEffect.removeEventListener(CustomEffectEvent.END, this.moveArrived);
			}
			this.setImage();
			this.isMoving = false;
			rotationY = 0;
			this.x = this._xPosition;
			this.y = this._yPosition;
			this.rotation = this.cardInfo["isAttack"] ? (0) : (90);
			if(cardInfo["slotType"] == CardSlotConst.handCardSlot && cardInfo["me"]){
				MatrixUtil.changeTo2D(this);
			}
			dispatchEvent(new Event("moveArrived"));
		}
		
		protected function clickCardHandler(event:MouseEvent):void
		{
			CombatStage.getInstance().mouseClickCard(this);
		}
		
		protected function mouseOutCardHandler(event:MouseEvent):void
		{
			CombatStage.getInstance().mouseOutCard(this);
		}
		
		protected function mouseOverCardHandler(event:MouseEvent):void
		{
			if (this.cardInfo["slotType"] == CardSlotConst.encampmentCardSlot && !this.cardInfo["isPositive"])
			{
				return;
			}
			if(!this.cardInfo["me"] && !this.cardInfo["isPositive"]){
				return;
			}
			CombatStage.getInstance().mouseOverCard(this);
		}
		
		public function get cardImage():CardImage
		{
			return _cardImage;
		}

		public function set cardImage(value:CardImage):void
		{
			_cardImage = value;
		}
	}
}