package com.syndrome.sanguo.battle.combat_ui.card
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.EncampmentCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.EquipmentCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.GeneralCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.GraveyardCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.HandCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.IncidentCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.MilitaryCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.PhalanxCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.StrategyCardSlot;
	import com.syndrome.sanguo.battle.common.CardInfo;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class CardManager
	{
		/**
		 * 游戏中所有的卡
		 */
		private var _cards:Array = [];
		
		protected var slots:Vector.<CardSlotBase>=new Vector.<CardSlotBase>();
		/**
		 * 当前战场上鼠标悬停的卡
		 */
		public var currentMouseOverCard:GameCard;
		
		/**
		 * 战团 （key ：战团id，value：{attackCards:[攻击的卡] , defenseCards:[防守的卡] } ）
		 */
		public var battleCards:Object = {};
		
		/**
		 * 阵型 （[阵型卡 ,阵型中的武将卡]）
		 */
		public var phalanxCards:Dictionary = new Dictionary();;
		
		private static var _instance:CardManager;
		public static function getInstance():CardManager
		{
			if(_instance == null){
				_instance = new CardManager();
			}
			return _instance;
		}
		
		public function CardManager()
		{
			initSlot();
		}
		
		/**
		 * 创建卡牌 ,创建的卡片为背面朝上
		 */
		public function createCard2(address:int , id:int , state:int):GameCard
		{
			var cardSlot:CardSlotBase = CardManager.getSlotByAddress(address);
			var cardInfo:Object = {};
			cardInfo["base"] = CardInfo.getCardInfoById(id);
			cardInfo["me"] = cardSlot.isMe;
			cardInfo["id"] = id;
			cardInfo["address"] = address;
			cardInfo["isAttack"] = getCardAttack(state);
			cardInfo["isPositive"] = getCardPositive(state);
			cardInfo["isSelectable"] = false;
			cardInfo["isSelected"] = false;
			cardInfo["slotType"] = cardSlot.type;
			var card:GameCard = new GameCard();
			var point:Point = getPointByAddress(address);
			card.x = point.x;
			card.y = point.y;
			card.setCardInfo(cardInfo);
			card.isMe = cardSlot.isMe;
			cardSlot.addCard(card , CardManager.getCardIndex(address));
			//			CombatConsole.getInstance().dispatchEvent(new MyEvent(MyEvent.CREATE_CARD, {card:card}));
			_cards.push(card);
			return card;
		}
		
		/**
		 * 创建卡牌 ,创建的卡片为背面朝上
		 */
		public function createCard(me:Boolean, id:int = 0) : GameCard
		{
			var cardSlot:CardSlotBase = CardManager.getSlotByType(CardSlotConst.encampmentCardSlot,me);
			var address:int = (me?0:100000) + 10000*cardSlot.type + cardSlot.getCardNum();
			return createCard2(address , id , CardConst.state_back);
		}
		
		/**
		 *改变卡的表现形式 
		 * @param toPositive
		 * @param toAttack
		 * @param changeRelateCard
		 * 
		 */
		public function changeState(card:GameCard , toPositive:Boolean, toAttack:Boolean) : void
		{
			CombatConsole.getInstance().addActionList([300, [function():void{
				var slot:CardSlotBase = CardManager.getSlotByAddress(card.cardInfo["address"]);
				slot.changeCardState(card,toPositive, toAttack);
			}]]);
		}
		
		/**
		 * 添加一组卡到对应位置
		 * @param cardArr 要添加的卡片
		 * @param slotType	卡片所在的卡槽
		 * @param toBack	是否背面朝上，默认是
		 * @param toDefensive	是否防守表示，默认是
		 * @param index	要添加到对应位置的索引，默认-1表示向后添加
		 * @param changeController 是否改变控制者 ， 默认不改变
		 * @param delay	多少毫秒后开始添加，默认为-1表示120(手牌)或者300(其他)
		 * @param equipIndex   如果slotType为装备槽此属性才有效 ， 表示装备槽的位置
		 */
		public function addCardArray(cardArr:Array, slotType:int, toBack:Boolean = true, toDefensive:Boolean = true, 
									 index:int = -1, changeController:Boolean = false, delay:int = -1) : void
		{
			var index:int = 0;
			while (index < cardArr.length)
			{
				this.addCard(cardArr[index], slotType, toBack, toDefensive, index, changeController, delay);
				index++;
			}
		}
		
		/**
		 * 添加装备卡
		 * @param equipCard 装备卡
		 * @param generalCard 目标武将卡
		 * @param delay 
		 */
		public function addEquipCard(equipCard:GameCard , generalCard:GameCard , delay:int = -1):void
		{
			if (delay == -1)
			{
				delay = 300;
			}
			else if(delay == 0)
			{
				this._addEquipCard(equipCard, generalCard);
				return;
			}
			CombatConsole.getInstance().addActionList([delay, [this._addEquipCard, equipCard, generalCard]]);
		}
		
		private function _addEquipCard(equipCard:GameCard , generalCard:GameCard):void
		{
			var originSlot:CardSlotBase = CardManager.getSlotByAddress(equipCard.cardInfo["address"]);
			var generalSlot:GeneralCardSlot = CardManager.getSlotByAddress(generalCard.cardInfo["address"]) as GeneralCardSlot;
			
			var destinationSlot:EquipmentCardSlot = generalSlot.getEquipSlot(generalCard);
			if(destinationSlot == null){
				destinationSlot = new EquipmentCardSlot(generalCard.cardInfo["me"] , generalCard);
			}
			if(originSlot != destinationSlot){
				originSlot.deleteCard(equipCard , destinationSlot);
			}
			destinationSlot.addCard(equipCard);
		}
		
		/**
		 *添加卡牌到对应位置 。 单纯的改变卡牌的表现形式使用changeState方法
		 * @param card  要添加的卡
		 * @param slotType	卡片所在的卡槽
		 * @param toBack	是否背面朝上，默认是
		 * @param toDefensive	是否防守表示，默认是
		 * @param index	要添加到对应位置的索引，默认-1表示向后添加
		 * @param changeController 是否改变控制者 ， 默认不改变
		 * @param delay	多少毫秒后开始添加，默认为-1表示120(手牌)或者300(其他)
		 */
		public function addCard(card:GameCard, slotType:int, toBack:Boolean = true, toDefensive:Boolean = true, index:int = -1, 
								changeController:Boolean = false, delay:int = -1) : void
		{
			if (delay == -1)
			{
				if(slotType == CardSlotConst.handCardSlot || card.cardInfo["slotType"] == CardSlotConst.handCardSlot){
					delay = 100;
				}else{
					delay = 300;
				}
			}
			else if(delay == 0)
			{
				this._addCard(card, slotType, toBack, toDefensive, index, changeController);
				return;
			}
			CombatConsole.getInstance().addActionList([delay, [this._addCard, card, slotType, toBack, toDefensive, index, changeController]]);
		}
		
		private function _addCard(card:GameCard, slotType:int, toBack:Boolean = false, toDefensive:Boolean = false, index:int = -1, 
								  changeController:Boolean = false) : void
		{
			var originSlot:CardSlotBase = CardManager.getSlotByAddress(card.cardInfo["address"]);
			var me:Boolean = card.cardInfo["me"];
			if(changeController){
				me = !me;
			}
			var destinationSlot:CardSlotBase = CardManager.getSlotByType(slotType , me);
			if(originSlot != destinationSlot){
				originSlot.deleteCard(card , destinationSlot);
			}
			card.changePosition(!toBack , !toDefensive);
			destinationSlot.addCard(card , index);
		}
		
		private function initSlot():void
		{
			for(var i:int = 0;i<=18;i++){
				var isMe:Boolean = !Boolean( int(i/10) );
				var type:int = i%10;
				switch(type){
					case 0: slots.push(new HandCardSlot(isMe));break;
					case 1: slots.push(new MilitaryCardSlot(isMe));break;
					case 2: slots.push(new StrategyCardSlot(isMe));break;
					case 3: slots.push(new IncidentCardSlot(isMe));break;
					case 4: slots.push(new GeneralCardSlot(isMe));break;
					case 5: slots.push(new EncampmentCardSlot(isMe));break;
					case 6: slots.push(new GraveyardCardSlot(isMe));break;
					case 7: slots.push(new CardSlotBase(isMe));break;
					case 8: slots.push(new PhalanxCardSlot(isMe));break;
					case 9: slots.push(new CardSlotBase(isMe));
				}
			}
		}
		
		/**
		 * 转换地址
		 */
		public static function convertAddress(address:int):int
		{
			if(address>=100000){
				address = address - 100000;
			}else{
				address = address + 100000;
			}
			return address;
		}
		
		/**
		 * 获取指定地址的坐标
		 */
		public static function getPointByAddress(address:int):Point
		{
			var solts:CardSlotBase = getSlotByAddress(address);
			var index:int = getCardIndex(address);
			return solts.getPointByIndex(index);
		}
		
		/**
		 * 获取指定地址的卡槽 ( 无法获取装备槽 )
		 * @param type 卡槽类型
		 * @param isMe 是否我方
		 * @param equipIndex 当卡槽类型为装备槽时，此参数有效，表示装备槽的index 。要获取正确的装备槽请确保装备的武将卡在正确的位置
		 */
		public static function getSlotByType(type:int , isMe:Boolean , equipIndex:int = 0):CardSlotBase
		{
			var slotType:int = type + (isMe?0:10);
			if(type == CardSlotConst.equipmentCardSlot){  //装备槽
				var generalCardSlot:GeneralCardSlot = getSlotByType(CardSlotConst.generalCardSlot , isMe) as GeneralCardSlot;
				var generalCard:GameCard = generalCardSlot.getCard(equipIndex);
				var equipSlot:EquipmentCardSlot = generalCardSlot.getEquipSlot(generalCard);
				if(equipSlot){
					return equipSlot;
				}else{
					return new EquipmentCardSlot(isMe , generalCard);
				}
			}else if(getInstance().slots.length>slotType){      //其他槽
				return getInstance().slots[slotType];
			}else{
				return null;
			}
		}
		
		/**
		 * 获取指定地址的卡槽
		 */
		public static function getSlotByAddress(address:int):CardSlotBase
		{
			var slotType:int = address/10000;
			var type:int = slotType>10?(slotType-10):slotType;
			var isMe:Boolean = slotType>10?false:true;
			var equipIndex:int = (address/100)%10;
			return getSlotByType(type , isMe , equipIndex);
		}
		
		/**
		 * 获取指定地址的卡牌的索引
		 */
		public static function getCardIndex(address:int):int
		{
			if((int(address/10000))%10 == CardSlotConst.equipmentCardSlot)
			{
				return address%100;
			}else{
				return address%1000;
			}
		}
		
		/**
		 * 获取指定地址的卡牌
		 */
		public static function getCard(address:int):GameCard
		{
			var cardslot:CardSlotBase = getSlotByAddress(address);
			return cardslot.getCard(getCardIndex(address));
		}
		
		/**
		 * 获取所有的卡
		 */
		public function getCards():Array
		{
			return _cards;
		}
		
		/**
		 * 依据状态获取卡牌是否正放
		 */
		public static function getCardPositive(state:int):Boolean
		{
			if(state ==0 || state ==CardConst.state_back || state==CardConst.state_transverse_back || state ==CardConst.state_back_link)//盖放
			{
				return false;
			}
			return true;
		}
		
		/**
		 * 依据状态获取卡牌是否横置
		 */
		public static function getCardAttack(state:int):Boolean
		{
			if(state ==CardConst.state_transverse || state ==CardConst.state_transverse_back || state==CardConst.state_transverse_link)
			{
				return false;
			}
			return true;
		}
		
		public function destroy():void
		{
			_cards.length = 0;
			slots = null;
			currentMouseOverCard = null;
			battleCards = {};
			phalanxCards = null;
			_instance = null;
		}
	}
}