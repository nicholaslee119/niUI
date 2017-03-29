package net.parameter
{
public class MessageParameters {
	public static const GAME_STAGE_DISPLAY:int = 10001;
	public static const FIRST_ACTION_PLAYER_DISPLAY:int = 10002;
	public static const MOVE_CARD_DISPLAY:int = 10003;
	public static const CARD_SLOT_INITIALIZATION_DISPLAY:int = 10004;
	public static const  SHUFFLE_CARD_SLOT_DISPLAY :int= 10005;
	public static const PROVISION_DISPLAY:int = 10006;
	public static const  SLOT_LIMIT_DISPLAY:int = 10007;
	public static const  INTERLINK_DISPLAY:int = 10008;
	public static const GENERAL_ATTRIBUTE_CHANGE_DISPLAY:int = 10009;
	public static const BATTLE_FIELD_DISPLAY:int = 10010;
	public static const CARD_DISPLAY:int =10011;
	public static const BATTLE_INJURY_DISPLAY:int =10012;
	public static const CARD_INJURY_DISPLAY:int =10013;
	public static const COUNT_DOWN_DISPLAY:int =10014;
	public static const COUNT_AMOUNT_TIME_DISPLAY:int =10015;
	public static const SWOP_CARD_SLOT:int =10016;
	public static const SHOW_MESSAGE:int =10018;
	public static const PHALANX_ATTRIBUTE_CHANGE_DISPLAY:int = 10019;
	
	public static const SLOT_CHANGE_DISPLAY:int = 10021;
	public static const CARD_ROUND_DISPLAY:int = 10022;
	
	public static const GAMEOVER_DISPLAY:int =10099;

	/**
	 * 玩家是否重置手牌
	 */
	public static const  REDEAL_REQUEST:int = 20001;
	public static const REDEAL_RESPOND:int = 30001;
	/**
	 * 玩家从卡牌的位置列表中选择卡牌
	 */
	public static const CHOOSE_CARD_FROM_LIST_REQUEST:int = 20002;
	public static const CHOOSE_CARD_FROM_LIST_RESPOND:int = 30002;
	/**
	 * 玩家从卡槽的位置列表中选择卡牌的询问
	 */
	public static const CHOOSE_SLOT_FROM_LIST_REQUEST:int = 20003;
	public static const CHOOSE_SLOT_FROM_LIST_RESPOND:int = 30003;
	/**
	 * 玩家从触发效果列表中选择效果的询问
	 */
	public static const CHOOSE_TRIGGER_EFFECT_REQUEST:int = 20004;
	public static const CHOOSE_TRIGGER_EFFECT_RESPOND:int = 30004;
	/**
	 * 玩家从列表中选择玩家技能或者卡牌的询问
	 */
	public static const CHOOSE_ACTION_REQUEST:int = 20005;
	public static const CHOOSE_ACTION_RESPOND:int = 30005;
	/**
	 * 玩家从卡牌技能列表选择技能的询问
	 */
	public static const CHOOSE_CARD_ACTION_REQUEST:int = 20006;
	public static const CHOOSE_CARD_ACTION_RESPOND:int = 30006;
	/**
	 * 超时，特殊的响应
	 */
	public static const TIME_OUT_RESPOND:int = 30007;
	/**
	 * 玩家给列出的卡牌进行排序的询问
	 */
	public static const SORT_CARD_REQUEST:int = 20008;
	public static const SORT_CARD_RESPOND:int = 30008;
	/**
	 * 玩家选择入阵的武将的询问
	 */
	public static const CHOOSE_PHALANX_GENERAL_REQUEST:int = 20009;
	public static const CHOOSE_PHALANX_GENERAL_RESPOND:int = 30009;
	/**
	 * 选择参加战斗的武将/阵型的询问
	 */
	public static const BATTLE_CARD_REQUEST:int = 20010;
	public static const BATTLE_CARD_RESPOND:int = 30010;
	/**
	 * 技能/禀赋/效果是否发动的询问
	 */
	public static const CONFIRM_TO_START_REQUEST:int = 20011;
	public static const CONFIRM_TO_START_RESPOND:int = 30011;
	/**
	 * 选择防守武将的询问
	 */
	public static const DEFENSE_GENERAL_REQUEST:int = 20012;
	public static const DEFENSE_GENERAL_RESPOND:int = 30012;
	
	/**
	 * 伤害分配
	 */
	public static const DISTRIBUTE_INJURY_REQUEST:int = 20013;
	public static const DISTRIBUTE_INJURY_RESPOND:int = 30013;
}
}