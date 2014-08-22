package com.syndrome.sanguo.battle.combat_ui
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.MilitaryCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.EffectGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.TipGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Card2DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Card3DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Effect3DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Scence3DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.window.cardwindow.CardDisplayWindow;
	import com.syndrome.sanguo.battle.event.MyEvent;
	import com.syndrome.sanguo.battle.event.OperationEvent;
	import com.syndrome.sanguo.battle.event.SelectAreaEvent;
	import com.syndrome.sanguo.battle.property.BattleFieldConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	import com.syndrome.sanguo.battle.property.ConstInterFace;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	
	import utils.ObjectUtil;
	
	/**
	 * 战斗舞台 包含 背景层------->2D场景层------->3D场景层------>3D卡片层------>3D特效层------>2D卡片层------>全局提示文字层------>弹窗层------>特效层
	 */
	public class CombatStage extends Group
	{
		public var tipGroup:TipGroup;
		public var popUpGroup:PopUpGroup;
		public var effectGroup:EffectGroup;
		
		public var scence3DCantainer:Scence3DCantainer;
		public var card3DCantainer:Card3DCantainer;
		public var effect3DCantainer:Effect3DCantainer;
		
		public var scence2DCantainer:Scence2DCantainer;
		public var card2DCantainer:Card2DCantainer;
		
		public function CombatStage()
		{
			super();
			this.transform.perspectiveProjection  = perspectiveProjection;   //设置3D视口
			this.addEventListener(MouseEvent.CLICK , stageClick);
			this.addEventListener(KeyboardEvent.KEY_DOWN,stageKeyDown);
		}
		
		protected function stageKeyDown(event:KeyboardEvent):void
		{
			if(event.altKey&&event.ctrlKey&&event.keyCode == Keyboard.H){
				CombatConsole.getInstance().dispatchEvent(new OperationEvent(OperationEvent.OPERATION , 99));
			}else if(event.keyCode == Keyboard.SPACE){
				CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.SKIP));
			}else if(event.keyCode == Keyboard.ENTER){
				CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.CONFIRM));
			}else if(event.keyCode == Keyboard.ESCAPE){
				CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.CANCEL));
			}
		}
		
		protected function stageClick(event:MouseEvent):void
		{
			this.setFocus();
		}
		
		private function get perspectiveProjection():PerspectiveProjection
		{
			var p:PerspectiveProjection  = new PerspectiveProjection();
			p.fieldOfView = BattleFieldConst.gameCanvas_fieldOfView;
			p.projectionCenter = new Point(
				BattleFieldConst.gameCanvas_projectionCenterX,BattleFieldConst.gameCanvas_projectionCenteY
			);
			return p;
		}
		
		private function get perspectiveProjection3D():PerspectiveProjection
		{
			var p:PerspectiveProjection  = new PerspectiveProjection();
			p.fieldOfView = BattleFieldConst.card3DCanvas_fieldOfView;
			p.projectionCenter = new Point(
				BattleFieldConst.card3DCanvas_projectionCenterX,BattleFieldConst.card3DCanvas_projectionCenterY
			);
			return p;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var backGroundImg:UIAsset = new UIAsset();
			backGroundImg.skinName = "IMG_Main_CombatBackGround";
			this.addElement(backGroundImg);
			
			scence2DCantainer = new Scence2DCantainer();
			scence2DCantainer.width = BattleFieldConst.gameCanvas_width;
			scence2DCantainer.height =  BattleFieldConst.stage_height;
			this.addElement(scence2DCantainer);
			
			var group3D:Group = new Group();
			group3D.rotationX = BattleFieldConst.card3DCanvas_rotationX;
			group3D.x = BattleFieldConst.group3DCanvas_x;
			group3D.y = BattleFieldConst.group3DCanvas_y;
			group3D.transform.perspectiveProjection  = perspectiveProjection3D;
			scence3DCantainer = new Scence3DCantainer();
			group3D.addElement(scence3DCantainer);
			card3DCantainer = new Card3DCantainer();
			group3D.addElement(card3DCantainer);
			effect3DCantainer  = new Effect3DCantainer();
			effect3DCantainer.y = BattleFieldConst.group3DChild_y;
			group3D.addElement(effect3DCantainer);
			this.addElement(group3D);

			card2DCantainer = new Card2DCantainer();
			this.addElement(card2DCantainer);
			
			tipGroup = new TipGroup();
			this.addElement(tipGroup);
			popUpGroup = new PopUpGroup();
			this.addElement(popUpGroup);
			effectGroup = new EffectGroup();
			this.addElement(effectGroup);
		}
		
		/**
		 * 清除所有卡的可选和选中效果
		 */
		public function cleanAllCardSelect():void
		{
			var cards:Array = CardManager.getInstance().getCards();
			for (var i:int = 0; i < cards.length; i++) 
			{
				cards[i].cardInfo["isSelectable"] = false;
				cards[i].cardInfo["isSelected"] = false;
				cards[i].setImage();
			}
		}
		
		/**
		 * 清理战场
		 */
		public function cleanStage():void
		{
			TipGroup.cleanText();
			popUpGroup.removeAllElements();
			effectGroup.removeAllElements();
			
			card3DCantainer.removeAllElements();
			card2DCantainer.myHandCardGroup.removeAllElements();
			card2DCantainer.enemyHandCardGroup.removeAllElements();
			card2DCantainer.battleCardGroup.removeAllElements();
			
			effect3DCantainer.reset();
			scence3DCantainer.reset();
			scence2DCantainer.reset();
			
			this.cardDisplayWindow = null;
		}
		
		public function mouseClickMilitary(isMe:Boolean , type:int):void
		{
			var militaryCardSlot:MilitaryCardSlot = CardManager.getSlotByType(CardSlotConst.militaryCardSlot , isMe) as MilitaryCardSlot;
			var cards:Array = militaryCardSlot.getMilitaryCards(type);
			if(cards.length == 0){
				return;
			}
			this.showCardDisplayWindow(cards , ConstInterFace.getWindowTitle(militaryCardSlot.type,militaryCardSlot.isMe,type));
		}
		
		public function mouseClickCard(card:GameCard) : void
		{
			var cardSlot:CardSlotBase = CardManager.getSlotByAddress(card.cardInfo["address"]);
			var isDispatch1:Boolean = CombatConsole.getInstance().dispatchEvent(new MyEvent(MyEvent.MOUSE_CLICK_CARD, {"card":card},false,true));
			var isDispatch2:Boolean =  CombatConsole.getInstance().dispatchEvent(new SelectAreaEvent(SelectAreaEvent.SELECTAREA , cardSlot));
			if(isDispatch1 && isDispatch2){
				if(cardSlot.type == CardSlotConst.graveyardCardSlot ||
					(cardSlot.type == CardSlotConst.incidentCardSlot && cardSlot.isMe) ||
					(cardSlot.type == CardSlotConst.phalanxCardSlot && cardSlot.isMe)){
					this.showCardDisplayWindow(cardSlot.getCards() , ConstInterFace.getWindowTitle(cardSlot.type,cardSlot.isMe));
				}
			}
		}
		
		public function mouseOverCard(card:GameCard) : void
		{
			CardManager.getInstance().currentMouseOverCard = card;
			CardInfoGroup.getInstance().showCard(card.cardInfo["id"]);
			CombatConsole.getInstance().dispatchEvent(new MyEvent(MyEvent.MOUSE_OVER_CARD, {card:card}));
		}
		
		public function mouseOutCard(card:GameCard) : void
		{
			CardManager.getInstance().currentMouseOverCard = null;
			CombatConsole.getInstance().dispatchEvent(new MyEvent(MyEvent.MOUSE_OUT_CARD, {card:card}));
		}
		
		private var cardDisplayWindow:CardDisplayWindow;
		/**
		 * 显示卡片弹窗
		 */
		public function showCardDisplayWindow(cards:Array, title:String = null) : void
		{
			if (!CombatConsole.getInstance().enableActionList)
			{
				return;
			}
			if(cardDisplayWindow && cardDisplayWindow.parent && title == cardDisplayWindow.title){
				cardDisplayWindow.removeSelf();
			}else{
				if(cardDisplayWindow && cardDisplayWindow.parent){
					cardDisplayWindow.removeSelf();
				}else{
					cardDisplayWindow = new CardDisplayWindow();
				}
				var cardInfos:Array = [];
				for (var i:int = 0; i < cards.length; i++) 
				{
					var cardInfo:Object = ObjectUtil.deepCopy(cards[i].cardInfo);
					cardInfo["isPositive"] = true;
					cardInfos.push(cardInfo);
				}
				cardDisplayWindow.title = title;
				cardDisplayWindow.addCardInfos(cardInfos);
				popUpGroup.addPopUp(cardDisplayWindow);
			}
		}
		
		public function removeCardDisplayWindow():void
		{
			if(cardDisplayWindow && cardDisplayWindow.parent){
				cardDisplayWindow.removeSelf();
			}
		}
		
		public static function getInstance():CombatStage
		{
			return CombatGroup.getInstance().combatStage;
		}
	}
}