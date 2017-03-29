package com.syndrome.sanguo.battle.combat_ui.stagegroup
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.combat_ui.card.CardCloseness;
	import com.syndrome.sanguo.battle.effect.swfeffect.SwfEffectBase;
	import com.syndrome.sanguo.battle.property.BattleFieldConst;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import manger.SoundManager;
	
	import org.flexlite.domDll.Dll;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.effects.Scale;
	import org.flexlite.domUI.events.EffectEvent;
	
	/**
	 * 游戏2D动画层
	 */
	public class EffectGroup extends Group
	{
		public function EffectGroup()
		{
			super();
			this.width = BattleFieldConst.gameCanvas_width;
			this.height = BattleFieldConst.stage_height;
			this.clipAndEnableScrolling = true;
		}
		
		/**
		 * 显示卡牌发动大图
		 */
		public function showCardCloseness(id:int , type:int = 1 , complete:Function = null):void
		{
			var  effectComplete:Function = function effectComplete(event:Event):void
			{
				cardcloseness.removeEventListener(Event.REMOVED_FROM_STAGE , effectComplete);
				if(complete != null){
					complete();
				}
				CombatConsole.getInstance().enableActionList = true;
			};
			CombatConsole.getInstance().enableActionList = false;
			var cardcloseness:CardCloseness = new CardCloseness();
			cardcloseness.type = type;
			cardcloseness.refreshCardInfo({"id":id},true);
			cardcloseness.isPositive = true;
			cardcloseness.verticalCenter = 0;
			cardcloseness.horizontalCenter = 0;
			cardcloseness.addEventListener(Event.REMOVED_FROM_STAGE , effectComplete);
			this.addElement(cardcloseness);
		}
		
		/**
		 * 播放攻击特效
		 * @param type 1:骑2:箭4:弓8:刀盾16:枪击
		 * @reversal 是否翻转
		 */
		public function playAttackEffect(type:int,point:Point,h_reversal:Boolean = false,v_reversal:Boolean = false,complete:Function = null):void
		{
			var clazz:Class;
			var soundStr:String;
			switch(type){
				case 1:
					clazz =  Dll.getRes("Scar_Horse") as Class;
					soundStr = "MP3_Horse";
					break;
				case 2:
					clazz =  Dll.getRes("Scar_Arrow") as Class;
					soundStr = "MP3_Arrow";
					break;
				case 4:
					clazz =  Dll.getRes("Scar_Arrow") as Class;
					soundStr = "MP3_Arrow";
					break;
				case 8:
					clazz =  Dll.getRes("Scar_Blade") as Class;
					soundStr = "MP3_Blade";
					break;
				case 16:
					clazz =  Dll.getRes("Scar_Lance") as Class;
					soundStr = "MP3_Spear";
					break;
				default:
					clazz =  Dll.getRes("Scar_Arrow") as Class;
					soundStr = "MP3_Blade";
			}
			SoundManager.play(soundStr);
			var swfEffect:SwfEffectBase = new SwfEffectBase(new clazz() as MovieClip);
			swfEffect.x = point.x;
			swfEffect.y = point.y;
			this.addElement(swfEffect);
			if(h_reversal){
				swfEffect.rotationY = 180;
			}
			if(v_reversal){
				swfEffect.rotationX = 180;
			}
			var swfEnd:Function = function(event:Event):void
			{
				swfEffect.removeEventListener(SwfEffectBase.SWF_EFFECT_END , swfEnd);
				if(complete != null){
					complete();
				}
			}
			swfEffect.addEventListener(SwfEffectBase.SWF_EFFECT_END , swfEnd);
			swfEffect.startPlay();
		}
		
		/**
		 * 播放流程提示效果
		 * @param type 2表示准备流程 1表示抓牌流程 3表示战斗流程 4表示结束流程
		 */
		public function playProcessesEffect(type:int , complete:Function = null):void
		{
			var clazz:Class;
			switch(type){
				case 1:
					clazz =  Dll.getRes("process_zp") as Class;
					break;
				case 2:
					clazz =  Dll.getRes("process_zb") as Class;
					break;
				case 3:
					clazz =  Dll.getRes("process_zd") as Class;
					break;
				case 4:
					clazz =  Dll.getRes("process_js") as Class;
					break;
				default:
					return;
			}
			SoundManager.play("MP3_Prompt");
			var swfEffect:SwfEffectBase = new SwfEffectBase(new clazz() as MovieClip);
			swfEffect.x = this.width/2;
			swfEffect.y = this.height/2 - 80;
			this.addElement(swfEffect);
			var swfEnd:Function = function(event:Event):void
			{
				if(complete != null){
					complete();
				}
				swfEffect.removeEventListener(SwfEffectBase.SWF_EFFECT_END , swfEnd);
			}
			swfEffect.addEventListener(SwfEffectBase.SWF_EFFECT_END , swfEnd);
			swfEffect.startPlay();
		}
		
		/**
		 * 播放先后攻效果
		 */
		public function playAttackOrderEffect(isFirst:Boolean):void
		{
			var resStr:String;
			if(isFirst){
				resStr =  "attack_first";
			}else{
				resStr =  "attack_last";
			}
			SoundManager.play("MP3_Start");
			Dll.getResAsync(resStr,function(bd:BitmapData):void{
				var uiAsset:UIAsset = new UIAsset();
				uiAsset.horizontalCenter = 0;
				uiAsset.verticalCenter = 0;
				uiAsset.skinName = bd;
				addElement(uiAsset);
				var isLast:Boolean = false;
				var scale:Scale = new Scale(uiAsset);
				scale.scaleXTo = 2;
				scale.scaleYTo = 2;
				scale.duration = 100;
				var end:Function = function(event:EffectEvent):void
				{
					if(isLast){
						scale.removeEventListener(EffectEvent.EFFECT_END , end);
						removeElement(uiAsset);
					}else{
						scale.startDelay = 50;
						scale.scaleXTo = 3;
						scale.scaleYTo = 3;
						scale.play();
						isLast = true;
					}
				}
				scale.addEventListener(EffectEvent.EFFECT_END , end);
				scale.play();
			});
		}
		
		public static function getInstance():EffectGroup
		{
			return CombatStage.getInstance().effectGroup;
		}
	}
}