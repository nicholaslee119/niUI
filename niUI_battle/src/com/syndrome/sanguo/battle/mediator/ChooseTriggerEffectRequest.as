package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardOpertionList;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.TipGroup;
	import com.syndrome.sanguo.battle.common.ConfigInfo;
	
	import components.MessageWindow;
	
	import flash.events.Event;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.events.ListEvent;

	/**
	 * 选择触发的效果
	 */
	public class ChooseTriggerEffectRequest implements IProtocolhandler
	{
		private var effects:Array;
		private var skips:Array;
		
		public function ChooseTriggerEffectRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			effects =message["effect"];
			skips =message["skip"];
			var event:int = int(message["event"]);
			var eventStr:String = ConfigInfo.getEventMsg(event);
			
			var strings:Array = [];
			for (var i:int = 0; i < effects.length; i++) 
			{
				strings.push(ConfigInfo.getActionMsg(effects[i].toString()));
			}
			
			CardOpertionList.getInstance().show(strings , null , false);
			TipGroup.showText(eventStr);
			CardOpertionList.getInstance().addEventListener(ListEvent.ITEM_CLICK , click);
			CardOpertionList.getInstance().addEventListener("hide" , hide);
			
			CombatConsole.getInstance().currentRequest = this;
		}
		
		protected function hide(event:Event):void
		{
			TipGroup.cleanText();
			CardOpertionList.getInstance().removeEventListener(ListEvent.ITEM_CLICK , click);
			CardOpertionList.getInstance().removeEventListener("hide" , hide);
		}		
		
		
		private var selectedIndex:int;
		private function click(event:ListEvent):void
		{
			var effect:String = effects[event.itemIndex];
			var skip:Boolean = skips[event.itemIndex];
			if(!skip)
			{
				var obj:Object = {};
				obj["id"] = MessageParameters.CHOOSE_TRIGGER_EFFECT_RESPOND;
				obj["effect"] = effect;
				obj["skip"] = skip;
				ESB.sendBattleMsg(obj);
			}else{
				selectedIndex = event.itemIndex;
				MessageWindow.show(ConfigInfo.getActionMsg(int(effect)) , "提示" , clickHandler);
			}
			CardOpertionList.getInstance().hide();
		}
		
		private function clickHandler(detail:String):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_TRIGGER_EFFECT_RESPOND;
			obj["effect"] = effects[selectedIndex];
			if(detail == MessageWindow.COMFIRM){
				obj["skip"] = false;
			}else{
				obj["skip"] = true;
			}
			ESB.sendBattleMsg(obj);
		}
		
		public function destroy():void
		{
			TipGroup.cleanText();
			CardOpertionList.getInstance().removeEventListener(ListEvent.ITEM_CLICK , click);
			CardOpertionList.getInstance().removeEventListener("hide" , hide);
			CardOpertionList.getInstance().hide();
		}
	}
}