package com.syndrome.client.parameters
{
	
	/*
	* 存放mainfram中需要的参数常量
	* @author nic
	* @build-time 2014-3-8
	* @comments
	*
	*/
	public class Constant
	{
		public function Constant(){}
		
		/**
		 *自动匹配大厅区
		 */		
		public static const AUTO_LOBBY:String = "sanguo-pair-zone";
		/**
		 *自由对战大厅区
		 */		
		public static const FREE_LOBBY:String = "sanguo-free-zone";
		/**
		 * 自动匹配大厅房间
		 */		
		public static const AUTO_LOBBY_ROOM:String = "sanguo-pair-lobby-room";
		/**
		 * 自由大厅房间 
		 */		
		public static const FREE_LOBBY_ROOM:String = "sanguo-free-lobby-room";
		/**
		 * 平台房间
		 */		
		public static const PLATFORM_ROOM:String = "sanguo-platform-room";
		/**
		 *练习大厅 
		 */		
		public static const PRACTISE_LOBBY:String = "sanguo-practice-zone";
		/**
		 * 获取卡组 
		 */		
		public static const GetCardGroup:String = "cgl";
		/**
		 * 获取练习卡组 
		 */		
		public static const GetPracticeCardGroup:String = "pcg";
		/**
		 * 获取当前卡组 
		 */		
		public static const GetCurrentCardGroup:String = "cgq";
		/**
		 * 设置当前卡组 
		 */		
		public static const SetCurrentCardGroup:String = "cgs";
		/**
		 * 获取玩家信息 
		 */		
		public static const GetUserInfo:String = "gui";
		/**
		 * 获取玩家状态 
		 */		
		public static const GetUserStatus:String = "status";
		/**
		 * 消费金币 
		 */		
		public static const CostGameGold:String = "cgd";
		/**
		 * 游戏结束 
		 */		
		public static const GameOver:String = "go";
		/**
		 *	游戏准备 
		 */		
		public static const GameReady:String = "gr";
		/**
		 *  游戏开始
		 */		
		public static const GameStart:String = "gs";
		/**
		 * 游戏取消准备 
		 */		
		public static const GameReadyCancel:String = "grc";
		/**
		 * 游戏状态 
		 */		
		public static const GameStauts:String = "ggs";
		/**
		 * 获取好友列表 
		 */		
		public static const GetFriendsList:String = "sfn";
		/**
		 * ES连接配置文件资源 
		 */		
		public static const ES_SETTINGS:String="settings";
		/**
		 * mainfram资源 名称
		 */		
		public static const RES_MAINFRAM:String="mainfram";
		/**
		 * 心跳消息 
		 */		
		public static const HEARTBEAT:String = "hb";
		/**
		 * 头像资源名称
		 */		
		public static const HEAD_IMAGES:String="headImages";
		/**
		 * 卡图像 
		 */		
		public static const CARD_IMAGES:String="cardImage";
		/**
		 * 场景localName
		 */		
		public static const SCENESXML:String="sceneUrl";
		/**
		 * 匹配大厅资源localName
		 */		
		public static const RES_AD:String="AutoLobbyAD";
		/**
		 * 平台场景 
		 */		
		public static const SCENE_PLATFORM:String = "PlatForm";
		/**
		 * 大厅场景 
		 */		
		public static const SCENE_LOBBY:String = "Lobby";
		/**
		 * 准备场景 
		 */		
		public static const SCENE_READYROOM:String = "ReadyRoom";
		/**
		 * 对战场景 
		 */		
		public static const SCENE_BATTLE:String = "Battle";
		/**
		 * 对战频道 
		 */		
		public static const CHANNEL_FIGHT:String = "channel_fight";
		/**
		 * 世界频道 
		 */		
		public static const CHANNEL_WORLD:String = "channel_world";
		/**
		 * 私聊频道 
		 */		
		public static const CHANNEL_PRIVATE:String = "channel_private";
		/**
		 * 大厅频道 
		 */		
		public static const CHANNEL_LOBBY:String = "channel_lobby";
		/**
		 * 战斗中 
		 */		
		public static const USER_STATUS_IN_FIGHT:int = 1;
		/**
		 * 空闲
		 */		
		public static const USER_STATUS_IDLE:int = 2;
		/**
		 * 在房间中等待 
		 */		
		public static const USER_STATUS_WAITING:int = 3;
		/**
		 * 在房间中已满 
		 */		
		public static const USER_STATUS_FULL:int = 4;
		/**
		 * 离线 
		 */		
		public static const USER_STATUS_OFFLINE:int = 5;
	}
}