package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Card3DCantainer;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.flexlite.domUI.components.Group;

	public class CardSlotBase
	{
		
		/**
		 * 卡槽中的卡
		 */
		protected var cards:Vector.<GameCard>=new Vector.<GameCard>;
		
		protected var _isMe:Boolean;
		
		protected var _point:Point;
		
		/**
		 * 卡槽
		 */
		public function CardSlotBase(isMe:Boolean)
		{
			_isMe = isMe;
		}
		
		/**
		 * 替换卡片
		 */
		public function replaceCard(card:GameCard,index:int):void
		{
			if(index>=cards.length){
				return;
			}
			cards[index] = card;
		}
		
		/**
		 * 改变卡牌的表现形式
		 */
		public function changeCardState(card:GameCard , toPositive:Boolean , toAttack:Boolean):void
		{
			if(cards.indexOf(card)<0){
				return;
			}
			var isPositiveOld:Boolean = card.cardInfo["isPositive"];
			var isAttackOld:Boolean = card.cardInfo["isAttack"];
			
			var changeComplete:Function = function(event:Event):void
			{
				card.removeEventListener("changeComplete" , changeComplete);
				if(!card.hasEventListener("changeComplete")){
					cardStateChanged(card , isPositiveOld , isAttackOld);
				}
			};
			card.addEventListener("changeComplete" , changeComplete);
			card.changePosition(toPositive , toAttack);
			refreshCardsPosition();
		}
		
		
		/**
		 * 向卡槽中添加卡片
		 */
		public function addCard(card:GameCard ,index:int = -1):void
		{
			card.cardInfo["me"] = isMe;
			card.cardInfo["slotType"] = type;
			if(index==-1){
				if(cards.indexOf(card)>=0){
					index = cards.length - 1;
				}else{
					index = cards.length;
				}
			}
			if(cards.indexOf(card)>=0){      //同卡槽内移动
				if(index == cards.indexOf(card)){  //位置不变
					refreshCardsPosition();
					return;
				}else{
					cards.splice(cards.indexOf(card),1);   //位置改变
				}
			}
			if(index>=cards.length){
				cards.length = index+1;
			}
			if(cards[index] == null){
				cards[index] = card;
			}else{
				cards.splice(index , 0 ,card);
			}
			if(card.parent != container){
				container.addElement(card);
			}else{
				container.setElementIndex(card,container.numElements-1);
			}
			var cardMoveArrived:Function = function(event:Event):void
			{
				card.removeEventListener("moveArrived" , cardMoveArrived);
				if(!card.hasEventListener("moveArrived")){
					cardReach(card);
				}
			};
			card.addEventListener("moveArrived" , cardMoveArrived);
			refreshCards();
			refreshCardsPosition();
		}
		
		/**
		 * 从卡槽中移除卡片
		 */
		public function deleteCard(card:GameCard , destinationSlot:CardSlotBase = null):void
		{
			if(cards.indexOf(card)<0){
				return;
			}
			card.cardInfo["old_slotType"] = type;
			if(destinationSlot){
				card.cardInfo["slotType"] = destinationSlot.type;
			}
			cards.splice(cards.indexOf(card),1);
			card.cardInfo["address"] = -1;
			cardLeave(card);
//			container.removeElement(card);
			refreshCards();
			refreshCardsPosition();
		}
		
		/**
		 * 从卡槽中移除所有卡片
		 */
		public function deleteAllCard():void
		{
			var cards:Array = getCards();
			for (var i:int = cards.length - 1; i >= 0; i--) 
			{
				deleteCard(cards[i]);
			}
		}
		
		/**
		 * 刷新卡槽中卡牌的属性( 地址等)
		 */
		public function refreshCards():void
		{
			for(var i:int = 0;i<cards.length;i++){
				if(cards[i] != null){
					var address:int = (isMe?type:(type+10))*10000 + i;
					cards[i].cardInfo["me"] = isMe;
					cards[i].cardInfo["address"] = address;
				}
			}
		}
		
		/**
		 * 卡片的表现形式改变
		 */
		public function cardStateChanged(card:GameCard , isPositiveOld:Boolean , isAttackOld:Boolean):void
		{
		}
		
		/**
		 * 卡片离开卡槽
		 */
		public function cardLeave(card:GameCard):void
		{
//			card.parent.setChildIndex(card,card.parent.numChildren-1);
		}
		
		/**
		 * 卡片达到卡槽
		 */
		public function cardReach(card:GameCard):void
		{
			var cards:Array = getCards();
			var index:int = cards.indexOf(card);
			if(index != 0){
				var preCard:GameCard = cards[index -1];
				var preCardIndex:int = container.getElementIndex(preCard);
				if(preCardIndex == container.numElements - 1){
					container.addElement(card);
				}else{
					container.addElementAt(card , preCardIndex+1);
				}
			}else if(cards.length > 1){
				var afterCard:GameCard = cards[index +1];
				var afterCardIndex:int = container.getElementIndex(afterCard);
				if(afterCard.parent == card.parent){
					container.addElementAt(card , preCardIndex+1);
				}
			}
		}
		
		/**
		 * 刷新卡槽中卡片的位置
		 */
		public function refreshCardsPosition():void
		{
			//TODO   刷新位置时应该刷新卡片的depth（childIndex）？
			var point:Point;
			for(var i:int = 0;i<cards.length;i++){
				if(cards[i] != null){
					point = CardManager.getPointByAddress(cards[i].cardInfo["address"]);
					cards[i].startMove(point.x , point.y);
				}
			}
		}
		
		/**
		 * 获取卡槽的卡片数量(包含空)
		 */
		public function getCardNum():int
		{
			return cards.length;
		}
		
		/**
		 * 获取卡槽所有的卡片
		 */
		public function getCards():Array
		{
			var arr:Array = [];
			for (var i:int = 0; i < cards.length; i++) 
			{
				if(cards[i] != null){
					arr.push(cards[i]);
				}
			}
			return arr;
		}
		
		
		/**
		 * 获取指定地址的卡牌
		 */
		public function getCard(index:int):GameCard
		{
			if(cards.length>index){
				return cards[index];
			}
			return null;
		}
		
		/**
		 * 通过地址获取坐标点,（使用此方法前确保卡槽的卡片数量已经更新完毕）
		 */
		public function getPointByIndex(index:int):Point
		{
			return new Point();
		}
		
		/**
		 * 卡槽的起始坐标
		 */
		public function get point():Point
		{
			return _point;
		}

		/**
		 * 卡槽类型
		 */
		public function get type():int
		{
			return -1;
		}

		/**
		 * 是否是我方卡槽
		 */
		public function get isMe():Boolean
		{
			return _isMe;
		}

		/**
		 * @private
		 */
		public function set isMe(value:Boolean):void
		{
			_isMe = value;
		}
		
		/**
		 * 卡槽中的卡片所在的容器
		 */
		public function get container():Group
		{
			return Card3DCantainer.getInstance();
		}
	}
}