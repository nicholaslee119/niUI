package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.CardOpertionList;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.common.ConfigInfo;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.ConstInterFace;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;
	
	import org.flexlite.domUI.events.ListEvent;

	/**
	 * 选择卡片操作
	 */
	public class ChooseCardActionRequest implements IProtocolhandler
	{
		private var actions:Array;

		private var cardSlot:CardSlotBase;
		
		public function ChooseCardActionRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			var actionType:String = message["actionType"];
			var address:int =message["address"];
			actions =message["actions"];
			var actionStrings:Array = [];
			
			for(var i:int =0; i<actions.length;i++)
			{
				var id:int =int(actions[i]);
				if(id<0)id=0;
				var actionString:String = ConfigInfo.getActionMsg(id);
				actionStrings.push(actionString);
			}
			if(actionType == "SLOT"){
				actionStrings.push("查看");
			}
			actionStrings.push("取消");
			
			var point:Point;
			if(actionType == "SLOT"){
				var isMe:Boolean = address>=10?false:true;
				var slotType:int = address>=10?address-10:address;
				cardSlot = CardManager.getSlotByType(slotType , isMe);
				point = cardSlot.container.localToGlobal(new Point(cardSlot.point.x+CardConst.width/2,cardSlot.point.y-CardConst.height/2));
				point = PopUpGroup.getInstance().globalToLocal(point);
			}else{
				var card:GameCard = CardManager.getCard(address);
				point = card.localToGlobal(card.cardInfo["isAttack"]?new Point(CardConst.width/2,-CardConst.height/2):new Point(-CardConst.width/2,-CardConst.height/2));
				point = PopUpGroup.getInstance().globalToLocal(point);
			}
			CardOpertionList.getInstance().show(actionStrings , point);
			CardOpertionList.getInstance().addEventListener(ListEvent.ITEM_CLICK , click);
			CardOpertionList.getInstance().addEventListener("hide" , hide);
			
			CombatConsole.getInstance().currentRequest = this;
		}
		
		protected function hide(event:Event):void
		{
			if(!sendFlag){
				var obj:Object = {};
				obj["id"] = MessageParameters.CHOOSE_CARD_ACTION_RESPOND;
				obj["action"] = "0";
				obj["cancel"] = true;
				ESB.sendBattleMsg(obj);
			}
			destroy();
		}
		
		private var sendFlag:Boolean;
		private function click(event:ListEvent):void
		{
			sendFlag = true;
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_CARD_ACTION_RESPOND;
			if(event.itemIndex >= actions.length)
			{
				if(cardSlot && event.itemIndex == actions.length){  //查看
					CombatStage.getInstance().removeCardDisplayWindow();
					CombatStage.getInstance().showCardDisplayWindow(cardSlot.getCards(),ConstInterFace.getWindowTitle(cardSlot.type,cardSlot.isMe));
				}
				obj["action"] = "0";
				obj["cancel"] = true;
			}
			else
			{
				obj["action"] = actions[event.itemIndex];
				obj["cancel"] = false;
			}
			ESB.sendBattleMsg(obj);
		}
		
		public function destroy():void
		{
			CardOpertionList.getInstance().removeEventListener(ListEvent.ITEM_CLICK , click);
			CardOpertionList.getInstance().removeEventListener("hide" , hide);
			CardOpertionList.getInstance().hide();
		}
	}
}