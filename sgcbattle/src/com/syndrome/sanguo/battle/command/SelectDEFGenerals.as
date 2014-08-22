package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.TipGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.event.MyEvent;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	
	import flash.events.Event;

	public class SelectDEFGenerals extends CommandBase
	{
		/**
		 *  战团对应的可防守将领  战团id：[武将地址]
		 */
		private var enableDefenseBattleGroup:Object = {};
		
		private var ensureEnable:Boolean;
		private var cancelEnable:Boolean;
		
		private var selectedATKCard:GameCard;
		private var selectedDEFCard:GameCard;

		private var eventStr:String = "";
		
		/**
		 * 选择防守将领
		 */
		public function SelectDEFGenerals()
		{
			super();
		}
		
		/**
		 * 选择防守将领 
		 * @param enableDefenseBattleGroup 战团对应的可防守将领  战团id：[武将地址]
		 * @param ensureEnable 是否可以确定
		 * @param cancelEnable 是否可以取消
		 * @param eventStr 事件
		 */
		public function show(enableDefenseBattleGroup:Object,ensureEnable:Boolean,cancelEnable:Boolean , eventStr:String = ""):void
		{
			this.enableDefenseBattleGroup = enableDefenseBattleGroup;
			this.ensureEnable = ensureEnable;
			this.cancelEnable = cancelEnable;
			this.eventStr = eventStr;
			this.init();
		}
		
		private function init():void
		{
			CombatConsole.getInstance().addEventListener(CombatConsole.CANCEL , cancelClick , false ,1);
			CombatConsole.getInstance().addEventListener(CombatConsole.CONFIRM , confirmClick , false ,1);
			CombatConsole.getInstance().addEventListener(MyEvent.MOUSE_CLICK_CARD , cardClick);
			for(var groupID:String in enableDefenseBattleGroup){
				showRoundATKGeneral(groupID , true);
			}
			Scence2DCantainer.getInstance().showOKCancel(ensureEnable , cancelEnable);
			TipGroup.showText(eventStr);
		}
		
		/**
		 * 取消按钮点击
		 */
		private function cancelClick(event:Event):void
		{
			destroy();
		}
		
		/**
		 * 确定按钮点击
		 */
		private function confirmClick(event:Event):void
		{
			destroy();
		}
		
		/**
		 * 选择进攻武将 , 让进攻武将可选
		 */
		private function showRoundATKGeneral(groupID:String , isShow:Boolean):void
		{
			var generals:Array = CardManager.getInstance().battleCards[groupID]["attackCards"];
			for (var i:int = 0; i < generals.length; i++) 
			{
				var card:GameCard = generals[i] as GameCard;
				card.cardInfo["isSelectable"] = isShow;
				card.setImage();
			}
		}
		
		/**
		 * 选择防守武将(显示可选中效果)
		 */
		private function showRoundDEFGeneral(groupID:String , isShow:Boolean):void
		{
			var generals:Array = enableDefenseBattleGroup[groupID];
			for (var i:int = 0; i < generals.length; i++) 
			{
				var card:GameCard = CardManager.getCard(generals[i]);
				card.cardInfo["isSelectable"] = isShow;
				card.setImage();
			}
		}
		
		private function cardClick(event:MyEvent):void
		{
			event.preventDefault();  //防止弹出展示框
			var card:GameCard = event.message["card"] as GameCard;
			if(selectedATKCard == null){
				if(card.cardInfo["isSelectable"]){
					atkCardClick(card);
					return;
				}
			}else{
				if(card.cardInfo["isSelectable"]){
					defCardClick(card);
					return;
				}
			}
		}
		
		/**
		 * 点击进攻卡片
		 */
		private function atkCardClick(card:GameCard):void
		{
			if(selectedATKCard == null){
				for(var groupID:String in enableDefenseBattleGroup){
					showRoundATKGeneral(groupID , false);
				}
				showRoundDEFGeneral(card.cardInfo["groupid"] , true);
				selectedATKCard = card;
			}else{
				selectedATKCard = null;
				for(groupID in enableDefenseBattleGroup){
					showRoundATKGeneral(groupID , true);
					showRoundDEFGeneral(groupID , false);
				}
			}
		}
		
		/**
		 * 点击防守卡片
		 */
		private function defCardClick(card:GameCard):void
		{
			CombatConsole.getInstance().dispatchEvent(new SelectEvent(SelectEvent.SELECT , [selectedATKCard.cardInfo["address"] , card.cardInfo["address"]]));
			for(var groupID:String in enableDefenseBattleGroup){
				showRoundDEFGeneral(groupID , false);
			}
			CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , cancelClick);
			CombatConsole.getInstance().removeEventListener(CombatConsole.CONFIRM , confirmClick);
			CombatConsole.getInstance().removeEventListener(MyEvent.MOUSE_CLICK_CARD , cardClick);
			super.destroy();
		}
		
		override protected function destroy():void
		{
			CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , cancelClick);
			CombatConsole.getInstance().removeEventListener(CombatConsole.CONFIRM , confirmClick);
			CombatConsole.getInstance().removeEventListener(MyEvent.MOUSE_CLICK_CARD , cardClick);
			for(var groupID:String in enableDefenseBattleGroup){
				showRoundATKGeneral(groupID , false);
				showRoundDEFGeneral(groupID , false);
			}
			Scence2DCantainer.getInstance().showOKCancel();
			TipGroup.cleanText();
		}
		
	}
}