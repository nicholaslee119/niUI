package com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D
{
	import app.config.AppConfig;
	
	import components.RoundSector;
	
	import manger.SoundManager;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.ProgressBar;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.core.IVisualElement;
	import org.flexlite.domUI.effects.animation.Animation;
	import org.flexlite.domUI.effects.animation.MotionPath;

	/**
	 * 角色信息窗口
	 */
	public class RoleInfoGroup extends SkinnableComponent
	{
		public var crisisMC:UIMovieClip;
		public var turnMC:UIMovieClip;
		public var handNumLabel:Label;
		public var nameLabel:Label;
		public var roleIconUI:UIAsset;
		public var turnTimeUI:ProgressBar;
		public var turnTimeLabel:Label;
		public var bloodUI:UIAsset;
		public var hpLabel:Label;
		public var timeOutFlagGroup:Group;
		
		protected var currentHpNum:int = 30;
		protected var maxHpNum:int = 30;
		
		/**
		 * 角色信息
		 */
		public function RoleInfoGroup()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			crisisMC.visible = false;
			turnMC.visible = false;
			turnTimeUI.value = turnTimeUI.maximum;
		}
		
		/**
		 * 重置
		 */
		public function reset():void
		{
			nameLabel.text = "";
			roleIconUI.skinName = "";
			setHandNum(0,7);
			setHpNum(30,30);
			setTurnTime(0,0);
			setTimeOutCount(0);
		}
		
		/**
		 * 设置超时次数
		 */
		public function setTimeOutCount(count:int):void
		{
			for (var i:int = 0; i < timeOutFlagGroup.numElements; i++) 
			{
				var element:IVisualElement = timeOutFlagGroup.getElementAt(i);
				if(count>0){
					element.includeInLayout = false;
					element.visible = false;
				}else{
					element.includeInLayout = true;
					element.visible = true;
				}
				count--;
			}
		}
		
		/**
		 * @param lostTime  剩下的时间  (秒为单位)
		 * @param totalTime  总时间
		 */
		public function setTurnTime(lostTime:Number , totalTime:Number):void
		{
			if(totalTime == 0)
			{
				turnTimeUI.value = turnTimeUI.maximum;
			}
			else
			{
				turnTimeUI.value = lostTime;
				turnTimeUI.maximum = totalTime;
			}
			if(lostTime != totalTime && (lostTime<5.5&&lostTime>0)){  //倒计时数字
				if(!SoundManager.isPlaying("MP3_Countdown")){
					SoundManager.play("MP3_Countdown" , true);
				}
				turnTimeLabel.visible = !turnTimeLabel.visible;
				turnTimeLabel.text = String(Math.round(lostTime));
			}else{
				if(SoundManager.isPlaying("MP3_Countdown")){
					SoundManager.stop("MP3_Countdown");
				}
				turnTimeLabel.visible = false;
			}
			
			if(lostTime !=totalTime){   //回合特效
				turnMC.visible = true;
			}else{
				turnMC.visible = false;
			}
		}
		
		/**
		 * 设置角色信息
		 * @param obj  属性字段有 icon , nickname
		 */
		public function setPlayerInfo(obj:Object):void
		{
			if(obj.hasOwnProperty("nickname")){
				nameLabel.text = obj["nickname"];
			}
			if(obj.hasOwnProperty("icon")){
				roleIconUI.skinName = AppConfig.roleIconFolder +obj["icon"];
			}
		}
		
		/**
		 * 获取手牌数量的文本
		 */
		public function getHandNum():int
		{
			if(handNumLabel){
				return int(handNumLabel.text.split("/")[0]);
			}else{
				return 0;
			}
		}
		
		/**
		 *设置手牌数量 
		 * @param currentNum 当前手牌数量
		 * @param maxNum 最大数量， 默认-1表示不重新设置
		 */
		public function setHandNum(currentNum:int , maxNum:int = -1):void
		{
			if(currentNum == -1){
				currentNum = getHandNum();
			}
			if(maxNum == -1){
				maxNum = int(handNumLabel.text.split("/")[1]);
			}
			handNumLabel.text = currentNum+"/"+maxNum;
		}
		
		/**
		 * 改变粮草
		 * @param currentNum 改变后的粮草
		 * @param maxNum 最大粮草数 ， -1表示不重新设置
		 */
		public function changeHpNum(currentNum:int , maxNum:int = -1) : void
		{
			if(currentNum>this.currentHpNum){
				SoundManager.play("MP3_Up");
			}else if(currentNum<this.currentHpNum){
				SoundManager.play("MP3_Down");
			}
			this.currentHpNum = currentNum>0?currentNum:0;
			if(maxNum != -1){
				maxHpNum = maxNum;
			}
			setHp();
		}
		
		/**
		 * 初始设置粮草数量
		 * @param hpNum 当前数量
		 */
		public function setHpNum(hpNum:int , maxNum:int = -1) : void
		{
			this.currentHpNum = hpNum;
			if(maxNum != -1){
				maxHpNum = maxNum;
			}
			setHp(false);
		}
		
		/**
		 * 设置血量百分比
		 */
		protected function setHp(isPlay:Boolean = true):void
		{
			crisisMC.visible = currentHpNum<=5;  //当前血量小于5 显示危机特效
			
			var maskRect:Rect = bloodUI.mask as Rect;
			if(maskRect!=null){
				if(isPlay){
					var endWidth:Number = bloodUI.width * currentHpNum / maxHpNum;
					var oldHpNum:int = int(hpLabel.text.split("/")[0]);
					var oldMaxHpNum:int = int(hpLabel.text.split("/")[1]);
					
					var updateFunction:Function = function(animation:Animation):void
					{
						maskRect.width = animation.currentValue["width"];
						hpLabel.text = Math.round(animation.currentValue["hpNum"])+"/"+Math.round(animation.currentValue["maxHpNum"]);
					}
					var animation:Animation = new Animation(updateFunction);
					animation.duration = 300;
					animation.motionPaths = new <MotionPath>[
						new MotionPath("width",maskRect.width,endWidth) ,
						new MotionPath("hpNum",oldHpNum,currentHpNum) ,
						new MotionPath("maxHpNum",oldMaxHpNum,maxHpNum)];
					animation.play();
				}else{
					maskRect.width = (currentHpNum / maxHpNum) *bloodUI.width;
					hpLabel.text = currentHpNum+"/"+maxHpNum;
				}
			}
		}
	}
}