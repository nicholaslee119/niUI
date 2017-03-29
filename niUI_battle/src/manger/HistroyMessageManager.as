package manger
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.chat.ChatGroup;
	import com.syndrome.sanguo.battle.common.CardInfo;
	import com.syndrome.sanguo.battle.common.UserInfo;
	import com.syndrome.sanguo.battle.common.ConfigInfo;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	import com.syndrome.sanguo.battle.property.ConstInterFace;
	
	import utils.StringUtils;

	public class HistroyMessageManager
	{
		public function HistroyMessageManager()
		{
		}
		
		/**
		 * 显示消息
		 */
		public static function displayChatMsg(id:int,param:Object):void
		{
			var str:String = ConfigInfo.getFormatMsg(id);
			for(var key:String in param){
				param[key] = convert(key,param[key]);
				str = str.replace(key,param[key]);
			}
			ChatGroup.getInstance().addText(StringUtils.parseColor("#h"+str+"#n"), 0);
		}
		
		private static function convert(key:String,value:*):String
		{
			switch(key){
				case "PLAYER":
				case "PLAYER1":
				case "PLAYER2":
					if(value == UserInfo.myUserName){
						return  StringUtils.parseColor("#p"+UserInfo.myNickName+"#n");
					}else{
						return  StringUtils.parseColor("#p"+UserInfo.enemyNickName+"#n");
					}
				case "REASON":
					var reasonStr:String  = ConfigInfo.getReasonMsg(value);
					reasonStr = reasonStr.replace(/\[/g,"[#c");
					reasonStr = reasonStr.replace(/]/g,"#n]");
					return StringUtils.parseColor(reasonStr);
				case "CARD":
					return StringUtils.parseColor("#c"+ CardInfo.getCardInfoById(value)["card_name"] +"#n");
				case "CARDS":
				case "ATTACKER":
				case "DEFENDER":
					var str:String = "";
					for each (var i:int in value){
						str += StringUtils.parseColor("#c"+ CardInfo.getCardInfoById(i)["card_name"] +"#n") +",";
					}
					return str.substr(0,str.length-1);
				case "CHOOSE_CARD":
					str = "";
					for each (var cardId:int in value){
						if(cardId > 0){
							str += StringUtils.parseColor("#c"+CardInfo.getCardInfoById(cardId)["card_name"]+"#n") +",";
						}else{
							str += "一张卡,";
						}
					}
					return str.substr(0,str.length-1);
				case "CARD_TYPE":
					var slotType:int = CardManager.getSlotByAddress(value).type;
					if(slotType == CardSlotConst.strategyCardSlot){
						return "谋略";
					}else if(slotType == CardSlotConst.generalCardSlot){
						if(CardManager.getCardIndex(value) == 0){
							return "主将";
						}else if(CardManager.getCardIndex(value) == 1){
							return "军师";
						}else{
							return "副将";
						}
					}else{
						return ConstInterFace.getSlotString(slotType);
					}
				case "GENERAL_TYPE":
					return getGeneralType(value);
				case "FROM":
				case "TO":
					return String(ConstInterFace.getSlotString(CardManager.getSlotByAddress(value).type));
				case "STATE":
				case "NEW_STATE":
				case "OLD_STATE":
					return ConstInterFace.getStateString(value);
				default:
					return String(value);
			}
		}
		
		private static function getGeneralType(value:int):String
		{
			switch(value)
			{
				case 1:
					return "骑兵";
				case 2:
					return "步兵";
				case 4:
					return "弓兵";
				case 8:
					return "刀盾";
				case 16:
					return "枪兵";
				default:
					return "武将";
			}
		}
		
	}
}