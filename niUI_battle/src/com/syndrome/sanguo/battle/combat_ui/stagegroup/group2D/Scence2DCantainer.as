package com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D
{
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.MilitaryButtonGroup;
	import com.syndrome.sanguo.battle.skin.EnemyRoleInfoSkin;
	import com.syndrome.sanguo.battle.skin.MyRoleInfoSkin;
	import com.syndrome.sanguo.battle.skin.button.FJButtonSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Alert;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.utils.callLater;
	
	public class Scence2DCantainer extends Group
	{
		private var okCancelButtonGroup:OKCancelButtonGroup;
		private var skipButtonGroup:SkipButtonGroup;
		private var operationButtonGroup:OperationButtonGroup;
		private var myRoleInfoGroup:RoleInfoGroup;
		private var enemyRoleInfoGroup:RoleInfoGroup;
		private var stateTipGroup:StateTipGroup;
		
		/**
		 * 2D场景层
		 */
		public function Scence2DCantainer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			okCancelButtonGroup = new OKCancelButtonGroup();
			okCancelButtonGroup.horizontalCenter = 0;
			okCancelButtonGroup.bottom = 160;
			this.addElement(okCancelButtonGroup);
			
			skipButtonGroup = new SkipButtonGroup();
			skipButtonGroup.horizontalCenter = 0;
			skipButtonGroup.bottom = 160;
			this.addElement(skipButtonGroup);
			
			operationButtonGroup = new  OperationButtonGroup();
			operationButtonGroup.right = 0;
			operationButtonGroup.bottom = 0;
			this.addElement(operationButtonGroup);
			
			myRoleInfoGroup = new RoleInfoGroup();
			myRoleInfoGroup.skinName = MyRoleInfoSkin;
			myRoleInfoGroup.bottom = 0;
			this.addElement(myRoleInfoGroup);
			
			enemyRoleInfoGroup = new RoleInfoGroup();
			enemyRoleInfoGroup.skinName = EnemyRoleInfoSkin;
			enemyRoleInfoGroup.top = 0;
			enemyRoleInfoGroup.right = 0;
			this.addElement(enemyRoleInfoGroup);
			
			stateTipGroup = new StateTipGroup();
			stateTipGroup.top = 0;
			stateTipGroup.left = 0;
			this.addElement(stateTipGroup);
			
			disabledAllButton();
		}
		
		/**
		 * 重置
		 */
		public function reset():void
		{
			disabledAllButton();
			myRoleInfoGroup.reset();
			enemyRoleInfoGroup.reset();
			stateTipGroup.setState(1,true,1);
		}
		
		/**
		 * 所有按钮设置不可用
		 */
		public function disabledAllButton():void
		{
			showOperations([]);
			showOKCancel();
			showSkip(false);
		}
		
		/**
		 *显示确认取消按钮 
		 * @param okEnable 确认按钮是否可用
		 * @param cancelEnable 取消按钮是否可用
		 */
		public function showOKCancel(okEnable:Boolean = false,cancelEnable:Boolean = false):void
		{
			okCancelButtonGroup.showOKCancel(okEnable , cancelEnable);
		}
		
		/**
		 * 显示跳过按钮
		 * @param enabled 是否可用
		 * 
		 */
		public function showSkip(enabled:Boolean = true):void
		{
			skipButtonGroup.showSkip(enabled);
		}
		
		/**
		 *显示可选动作   
		 * @param enabledArray  0：摆放兵权		1：征兵		2：取镇		3：伏将		4：伏谋		5：遣将
		 * 
		 */
		public function showOperations(enabledArray:Array):void
		{
			operationButtonGroup.showOperations(enabledArray);
		}
		
		/**
		 * 获取手牌数量的文本
		 */
		public function getHandNum(isMe:Boolean):int
		{
			if(isMe){
				return myRoleInfoGroup.getHandNum();
			}else{
				return enemyRoleInfoGroup.getHandNum();
			}
		}
		
		/**
		 *设置手牌数量 
		 * @param isMe 是否我方
		 * @param currentNum 当前手牌数量 , -1表示不重新设置
		 * @param maxNum 最大数量， 默认-1表示不重新设置
		 */
		public function setHandNum(isMe:Boolean , currentNum:int , maxNum:int = -1):void
		{
			if(isMe){
				myRoleInfoGroup.setHandNum(currentNum , maxNum);
			}else{
				enemyRoleInfoGroup.setHandNum(currentNum , maxNum);
			}
		}
		
		/**
		 * 初始设置粮草数量
		 * @param hpNum 当前数量
		 * @param isMe 是否我方
		 */
		public function setHpNum(hpNum:int , maxNum:int , isMe:Boolean) : void
		{
			if(isMe){
				myRoleInfoGroup.setHpNum(hpNum , maxNum);
			}else{
				enemyRoleInfoGroup.setHpNum(hpNum , maxNum);
			}
		}
		
		/**
		 * 改变粮草
		 * @param currentNum 改变后的粮草
		 * @param maxNum 最大粮草数 ， -1表示不重新设置
		 */
		public function changeHpNum(currentNum:int , maxNum:int , isMe:Boolean) : void
		{
			if(isMe){
				myRoleInfoGroup.changeHpNum(currentNum , maxNum);
			}else{
				enemyRoleInfoGroup.changeHpNum(currentNum ,maxNum);
			}
		}
		
		/**
		 * 设置超时次数
		 */
		public function setTimeOutCount(count:int , isMe:Boolean):void
		{
			if(isMe){
				myRoleInfoGroup.setTimeOutCount(count);
			}else{
				enemyRoleInfoGroup.setTimeOutCount(count);
			}
		}
		
		/**
		 * 
		 * @param lostTime  剩下的时间
		 * @param totalTime  总时间
		 * @param isMe  是否是我方
		 */
		public function setTurnTime(lostTime:Number , totalTime:Number , isMe:Boolean):void
		{
			if(isMe){
				myRoleInfoGroup.setTurnTime(lostTime , totalTime);
			}else{
				enemyRoleInfoGroup.setTurnTime(lostTime , totalTime);
			}
		}
		
		/**
		 * 设置玩家信息
		 * @param obj 属性字段有 icon , nickname 
		 * @param isMe 是否我方
		 */
		public function setPlayInfo(obj:Object , isMe:Boolean):void
		{
			if(isMe){
				myRoleInfoGroup.setPlayerInfo(obj);
			}else{
				enemyRoleInfoGroup.setPlayerInfo(obj);
			}
		}
		
		/**
		 * 设置流程回合状态
		 * @param gameState  1抓牌 2准备 3战斗 4结束
		 * @param isMyTurn  是否是我方回合
		 * @param roundIndex 第几回合
		 */
		public function setState(gameState:int , isMyTurn:Boolean , roundIndex:int):void
		{
			stateTipGroup.setState(gameState , isMyTurn  , roundIndex);
		}
		
		public static function getInstance():Scence2DCantainer
		{
			return CombatStage.getInstance().scence2DCantainer;
		}
	}
}