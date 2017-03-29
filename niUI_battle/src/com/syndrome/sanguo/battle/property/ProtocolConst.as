package com.syndrome.sanguo.battle.property
{
	public class ProtocolConst
	{
		public static const GAME_TIMEOUT_DISPLAY:int =10014;
		
		public static const GAME_TIMEOUTCOUNT_DISPLAY:int =10015;
		public static const GAME_CHANGGE_SITE:int =10016;
		public static const GAME_CARDIN_TOP_DISPLAY:int =10017;
		
		/**
		 * 展示游戏开始
		 */
		public static const GAME_STAGE_DISPLAY:int = 10001;
		/**
		 * 展示初始行动玩家
		 */
		public static const FIRST_ACTION_PLAYER_DISPLAY:int = 10002;
		/**
		 * 卡牌移动的消息
		 */
		public static const MOVE_CARD_DISPLAY:int = 10003;
		
		/**
		 * 卡槽中的卡牌的初始化信息，包括营地和事件
		 */
		public static const CARD_SLOT_INITIALIZATION_DISPLAY:int = 10004;
		
		/**
		 * 营地卡牌重洗后位置
		 */
		public static const  ENCAMPMENT_CARD_DISPLAY :int= 10005;
		
		/**
		 * 粮草变化显示
		 */
		public static const PROVISION_DISPLAY:int = 10006;
		
		/**
		 * 卡槽数量上限变化显示
		 */
		public static const  SLOT_LIMIT_DISPLAY:int = 10007;
		
		/**
		 * 连环内容更新
		 */
		public static const  INTERLINK_DISPLAY:int = 10008;
		
		/**
		 * 武将属性变化显示
		 */
		public static const GENERAL_ATTRIBUTE_CHANGE_DISPLAY:int = 10009;
		
		/**
		 * 阵型属性变化显示
		 */
		public static const PHALANX_ATTRIBUTE_CHANGE_DISPLAY:int = 10009;
		
		public static const GAMEOVER_DISPLAY:int =10099;
		/**
		 * 战场展示，主要针对战团
		 */
		public static const BATTLE_FIELD_DISPLAY:int = 10010;
		
		public static const CARD_DISPLAY:int =10011;
		
		public static const BATTLE_HURT_DISPLAY:int =10012;
		
		public static const BATTLE_HURT_GENERLDISPLAY:int =10013;
		
		public static const MSGFORMAT_DISPLAY:int =10018;
		/**
		 * 玩家是否重置手牌询问
		 */
		public static const  REDEAL_REQUEST:int = 20001;
		/**
		 * 玩家是否重置手牌应答
		 */
		public static const REDEAL_RESPOND:int = 30001;
		
		/**
		 * 玩家从卡牌的位置列表中选择卡牌的询问
		 */
		public static const CHOOSE_CARD_FROM_LIST_REQUEST:int = 20002;
		
		/**
		 * 玩家从卡牌的位置列表中选择卡牌的应答
		 */
		public static const CHOOSE_CARD_FROM_LIST_RESPOND:int = 30002;
		
		/**
		 * 玩家从卡槽的位置列表中选择卡牌的询问
		 */
		public static const CHOOSE_SLOT_FROM_LIST_REQUEST:int = 20003;
		
		/**
		 * 玩家从卡槽的位置列表中选择卡牌的应答
		 */
		public static const CHOOSE_SLOT_FROM_LIST_RESPOND:int = 30003;
		
		/**
		 * 玩家从触发效果列表中选择效果的询问
		 */
		public static const CHOOSE_TRIGGER_EFFECT_REQUEST:int = 20004;
		
		/**
		 * 玩家从触发效果列表中选择效果的应答
		 */
		public static const CHOOSE_TRIGGER_EFFECT_RESPOND:int = 30004;
		
		/**
		 * 玩家从列表中选择玩家技能或者卡牌的询问
		 */
		public static const CHOOSE_ACTION_REQUEST:int = 20005;
		
		/**
		 * 玩家从列表中选择玩家技能或者卡牌的应答
		 */
		public static const CHOOSE_ACTION_RESPOND:int = 30005;
		
		/**
		 * 玩家从卡牌技能列表选择技能的询问
		 */
		public static const CHOOSE_CARD_ACTION_REQUEST:int = 20006;
		
		/**
		 * 玩家从卡牌技能列表选择技能的应答
		 */
		public static const CHOOSE_CARD_ACTION_RESPOND:int = 30006;
		
		/**
		 * 超时，特殊的响应
		 */
		public static const TIME_OUT_RESPOND:int = 30007;
		
		/**
		 * 玩家给列出的卡牌进行排序的询问
		 */
		public static const SORT_CARD_REQUEST:int = 20008;
		
		/**
		 * 玩家给列出的卡牌进行排序的应答
		 */
		public static const SORT_CARD_RESPOND:int = 30008;
		
		/**
		 * 玩家选择入阵的武将的询问
		 */
		public static const CHOOSE_PHALANX_GENERAL_REQUEST:int = 20009;
		
		/**
		 * 玩家选择入阵的武将的应答 
		 */
		public static const CHOOSE_PHALANX_GENERAL_RESPOND:int = 30009;
		
		/**
		 * 选择参加战斗的武将/阵型的询问
		 */
		public static const BATTLE_CARD_REQUEST:int = 20010;
		
		/**
		 * 选择参加战斗的武将/阵型的应答
		 */
		public static const BATTLE_CARD_RESPOND:int = 30010;
		
		/**
		 * 技能/禀赋/效果是否发动的询问
		 */
		public static const CONFIRM_TO_START_REQUEST:int = 20011;
		
		/**
		 * 技能/禀赋/效果是否发动的应答
		 */
		public static const CONFIRM_TO_START_RESPOND:int = 30011;
		
		/**
		 * 选择防守武将的询问
		 */
		public static const DEFENSE_GENERAL_REQUEST:int = 20012;
		/**
		 * 选择防守武将的应答
		 */
		public static const DEFENSE_GENERAL_RESPOND:int = 30012;
		
		public static const DISTRIBUTE_INJURY_REQUEST:int = 20013;
		public static const DISTRIBUTE_INJURY_RESPOND:int = 30013;
		
		
		public function ProtocolConst()
		{
		}
	}
}