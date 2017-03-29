package net
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.DebugWindow;
	import com.syndrome.sanguo.battle.common.UserInfo;
	import com.syndrome.sanguo.battle.mediator.*;
	
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import net.parameter.MessageParameters;
	
	public class BattleMessageCenter
	{
		private var userUpdate:UserUpdate;
		private var gameStateUpdate:GameStateUpdate;
		private var channelMessageUpdate:ChannelMessageUpdate;
		
		public function BattleMessageCenter()
		{
		}
		
		private static function get messageClassPath():String
		{
			return "com.syndrome.sanguo.battle.mediator.";
		}
		
		/**
		 * 接受到消息
		 */
		public static function receive2(className:String , message:Object):void
		{
			DebugWindow.traceMsg(message);
			
			className = messageClassPath + className.substring(className.lastIndexOf(".")+1);
			var clazz:Class = getDefinitionByName(className) as Class;
			var protocol:* = new clazz() as IProtocolhandler;
			protocol.handle(message);
		}
		
		/**
		 *接收到战斗消息 
		 * @param message  必须字段有 id
		 * 
		 */
		public static function receive(message:Object):void
		{
			DebugWindow.traceMsg(message);
			
			if(!message.hasOwnProperty("id")){
				return;
			}
			var id:int =message["id"];
			
			var protocol:* = getMessageClass(id);
			var delayFun:Function = function(event:Event):void
			{
				if(message.hasOwnProperty("type") && message["type"] == 11)  //需要计时
				{
					(new CountDownDisplay()).handle({"timeOut":message["timeOut"] , "playerName":UserInfo.myUserName});
				}
				event.stopImmediatePropagation();
				CombatConsole.getInstance().removeEventListener(CombatConsole.WAITING , delayFun);
//				protocol.handle(message);
				CombatConsole.getInstance().addActionList([10,[protocol.handle,message]]);
			}
			CombatConsole.getInstance().addEventListener(CombatConsole.WAITING , delayFun);
		}
		
		public static function getMessageClass(id:int):IProtocolhandler
		{
			switch(id)
			{
				case MessageParameters.COUNT_DOWN_DISPLAY:
					return new CountDownDisplay;
				case MessageParameters.COUNT_AMOUNT_TIME_DISPLAY:
					return new CountTime;
				case MessageParameters.PROVISION_DISPLAY:
					return new ProvisionDisplay;
				case MessageParameters.GAME_STAGE_DISPLAY:
					return new GameStageDisplay;
				case MessageParameters.FIRST_ACTION_PLAYER_DISPLAY:
					return new FirstActionPlayerDisplay;
				case MessageParameters.REDEAL_REQUEST:
					return new RedealRequest;
				case MessageParameters.GENERAL_ATTRIBUTE_CHANGE_DISPLAY:
					return new GeneralAttributeChangeDisplay;
				case MessageParameters.MOVE_CARD_DISPLAY:
					return new MoveCardDisplay;
				case MessageParameters.CARD_SLOT_INITIALIZATION_DISPLAY:
					return new InitCardSlotDisplay;
				case MessageParameters.SHUFFLE_CARD_SLOT_DISPLAY:
					return new ShuffleCardSlotDisplay;
				case MessageParameters.SLOT_CHANGE_DISPLAY:
					return new SlotChangeDisplay;
				case MessageParameters.CARD_ROUND_DISPLAY:
					return new CardRoundDisplay;
				case MessageParameters.CHOOSE_ACTION_REQUEST:
					return new ChooseActionRequest;
				case MessageParameters.CHOOSE_CARD_ACTION_REQUEST:
					return new ChooseCardActionRequest;
				case MessageParameters.CHOOSE_CARD_FROM_LIST_REQUEST:
					return new ChooseCardFromListRequest;
				case MessageParameters.CHOOSE_SLOT_FROM_LIST_REQUEST:
					return new ChooseSlotFromListRequest;
				case MessageParameters.CHOOSE_TRIGGER_EFFECT_REQUEST:
					return new ChooseTriggerEffectRequest;
				case MessageParameters.CONFIRM_TO_START_REQUEST:
					return new ConfirmToStartRequest;
				case MessageParameters.SORT_CARD_REQUEST:
					return new SortCardRequest;
				case MessageParameters.BATTLE_CARD_REQUEST:
					return new BattleCardRequest;
				case MessageParameters.BATTLE_FIELD_DISPLAY:
					return new BattleFieldDisplay;
				case MessageParameters.DEFENSE_GENERAL_REQUEST:
					return new DefenseGeneralRequest;
				case MessageParameters.DISTRIBUTE_INJURY_REQUEST:
					return new DistributeInjuryRequest;
				case MessageParameters.CARD_DISPLAY:
					return new CardDisplay;
				case MessageParameters.BATTLE_INJURY_DISPLAY:
					return new BattleInjuryDisplay;
				case MessageParameters.CARD_INJURY_DISPLAY:
					return new CardInjuryDisplay;
				case MessageParameters.INTERLINK_DISPLAY:
					return new LinkDisplay;
				case MessageParameters.GAMEOVER_DISPLAY:
					return new GameOverDisplay;
				case MessageParameters.SWOP_CARD_SLOT:
					return new SwopCard;
				case MessageParameters.SHOW_MESSAGE:
					return new MessageDisplay;
				case MessageParameters.SLOT_LIMIT_DISPLAY:
					return new SlotLimitDisplay;
				case MessageParameters.CHOOSE_PHALANX_GENERAL_REQUEST:
					return new ChoosePhalanxGeneralRequest;
				case MessageParameters.PHALANX_ATTRIBUTE_CHANGE_DISPLAY:
					return new PhalanxAttributeChangeDisplay;
					return 
				default:
					trace("收到未知业务逻辑");
					return null;
			}
		}
	}
}