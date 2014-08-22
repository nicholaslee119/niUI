package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.CardOpertionList;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.IncidentCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Card3DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.window.cardwindow.CardSelectableWindow;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;
	
	import org.flexlite.domUI.events.ListEvent;
	
	import utils.ObjectUtil;
	
	/**
	 * 选择发动事件
	 */
	public class ChooseIncidentCardRequest implements IProtocolhandler
	{
		private var window:CardSelectableWindow;
		private var chooseActionMessage:Object; 
		private var cardAddress:Array;
		
		private var incidentCardSlot:IncidentCardSlot; 
		
		public function ChooseIncidentCardRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			cardAddress = message["cardAddress"];
			chooseActionMessage = message["chooseActionMessage"];
			
			incidentCardSlot = CardManager.getSlotByType(CardSlotConst.incidentCardSlot , true) as IncidentCardSlot;
			var point:Point = Card3DCantainer.getInstance().localToGlobal(new Point(incidentCardSlot.point.x+CardConst.width/2,incidentCardSlot.point.y-CardConst.height/2));
			point = PopUpGroup.getInstance().globalToLocal(point);
			CardOpertionList.getInstance().show(["发动","查看","取消"],point);
			CardOpertionList.getInstance().addEventListener(ListEvent.ITEM_CLICK , click);
			CardOpertionList.getInstance().addEventListener("hide" , hide);			

			CombatConsole.getInstance().currentRequest = this;
		}
		
		protected function hide(event:Event):void
		{
			if(listSelectedIndex!=0){
				onCancel(event);
			}
		}
		
		private var listSelectedIndex:int = -1;
		protected function click(event:ListEvent):void
		{
			listSelectedIndex = event.itemIndex;
			if(listSelectedIndex == 0){   //发动
				selectCardFromWindow();
			}else if(listSelectedIndex == 1){    //查看
				CombatStage.getInstance().removeCardDisplayWindow();
				CombatStage.getInstance().showCardDisplayWindow(incidentCardSlot.getCards(),"我方事件卡牌");
			}
		}
		
		private function selectCardFromWindow():void
		{
			var cardsArr:Array = [];
			for (var i:int = 0; i < cardAddress.length; i++) 
			{
				var card:GameCard = CardManager.getCard(cardAddress[i]);
				var cardInfo:Object = ObjectUtil.deepCopy(card.cardInfo);
				cardInfo["isPositive"] = true;
				cardInfo["isSelectable"] = false;
				cardInfo["isSelected"] = false;
				cardsArr.push(cardInfo);
			}
			window = new CardSelectableWindow();
			window.addCardInfos(cardsArr);
			window.setInfo(1 , 1 , true , "选择要发动的事件");
			PopUpGroup.getInstance().addPopUp(window);
			CombatConsole.getInstance().addEventListener(CombatConsole.CANCEL , onCancel);
			CombatConsole.getInstance().addEventListener(SelectEvent.SELECT , onSelect);
		}		
		
		protected function onSelect(event:SelectEvent):void
		{
			if(event.data.length>0){
				var obj:Object = {};
				obj["id"] = MessageParameters.CHOOSE_ACTION_RESPOND;
				obj["cardAddress"] = event.data[0];
				ESB.sendBattleMsg(obj);
			}else{
				(new ChooseActionRequest()).handle(chooseActionMessage);
			}
			destroy();
		}
		
		protected function onCancel(event:Event):void
		{
			(new ChooseActionRequest()).handle(chooseActionMessage);
			destroy();
		}
		
		public function destroy():void
		{
			CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , onCancel);
			CombatConsole.getInstance().removeEventListener(SelectEvent.SELECT , onSelect);
			CardOpertionList.getInstance().removeEventListener(ListEvent.ITEM_CLICK , click);
			CardOpertionList.getInstance().removeEventListener("hide" , hide);
		}
	}
}