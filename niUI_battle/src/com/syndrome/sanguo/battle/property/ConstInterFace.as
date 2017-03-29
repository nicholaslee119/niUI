package com.syndrome.sanguo.battle.property
{
	public class ConstInterFace
	{
		public function ConstInterFace()
		{
		}
		
		/**
		 *  str 类型   INFANTRY：步兵  ARCHER：弓兵 CAVALRY：骑兵  ADVISER：谋士
		 */
		public static function getMilitaryType(str:String):int
		{
			if(str == "INFANTRY"){
				return 3;
			}else if(str == "ARCHER"){
				return 2;
			}else if(str == "CAVALRY"){
				return 1;
			}else if(str == "ADVISER"){
				return 0;
			}
			return NaN;
		}
		
		/**
		 * 获取窗口标题
		 * @param slot  卡槽类型
		 * @param isMe 是否是我方
		 * @param militaryType  兵权类型 （当slot是兵权槽是才有效）
		 * @return 字符串
		 */
		public static function getWindowTitle(slot:int,isMe:Boolean,militaryType:int = 0):String
		{
			var str:String = "";
			if(isMe){
				str+= "我方";
			}else{
				str+= "敌方";
			}
			if(slot == CardSlotConst.militaryCardSlot){
				if(militaryType==0){
					str += "谋士";
				}else if(militaryType==1){
					str += "骑兵";
				}else if(militaryType==2){
					str += "弓兵";
				}else{
					str += "步兵";
				}
			}
			str += getSlotString(slot);
			return str;
		}

		public static function getStateString(state:int):String
		{
			if(state == 1)return "正放";
			else if(state == 2)return "盖放";
			else if(state == 3)return "横置";
			else if(state == 4)return "横置盖放";
			else if(state == 5)return "连环中";
			else if(state == 6)return "横置在连环中";
			else if(state == 7)return "盖放在连环中";
			else if(state == 8)return "阵亡";
			else if(state == 9)return "破坏";
			else if(state == 10)return "移除游戏";
			else return "";
		}
		
		public static function getSlotString(slot:int):String
		{
			if(slot == 0)return "手牌";
			else if(slot == 1)return "兵权";
			else if(slot == 2)return "谋略";
			else if(slot == 3)return "事件";
			else if(slot == 4)return "武将";
			else if(slot == 5)return "营地";
			else if(slot == 6)return "墓地";
			else if(slot == 7)return "宝物";
			else if(slot == 8)return "阵型";
			else return "";
		}
	}
}