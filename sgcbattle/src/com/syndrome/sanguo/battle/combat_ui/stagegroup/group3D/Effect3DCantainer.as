package com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D
{
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.effect.swfeffect.SwfEffectBase;
	import com.syndrome.sanguo.battle.skin.Effect3DCantainerSkin;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import manger.SoundManager;
	
	import org.flexlite.domDll.Dll;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.SkinnableContainer;
	import org.flexlite.domUI.components.UIAsset;
	
	/**
	 * 3D动画层
	 */
	public class Effect3DCantainer extends SkinnableContainer
	{
		public var myEncampmentNumLabel:Label;
		public var enemyEncampmentNumLabel:Label;
		public var myMDNumLabel:Label;
		public var enemyMDNumLabel:Label;

		public function Effect3DCantainer()
		{
			super();
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.skinName = Effect3DCantainerSkin;
		}
		
		/**
		 * 播放阵亡特效
		 */
		public function playDeadEffect(point:Point , target:GameCard,  complete:Function = null):void
		{
			SoundManager.play("MP3_Dead");
			var bombEndHandler:Function = function(e:Event):void
			{
				swfEffect.removeEventListener(SwfEffectBase.SWF_EFFECT_END , bombEndHandler);
				if(complete != null){
					complete();
				}
			}
			var clazz:Class  = Dll.getRes("Effect_Dead") as Class;
			var mc:MovieClip = new clazz() as MovieClip;
			var swfEffect:SwfEffectBase = new SwfEffectBase(mc);
			mc.addFrameScript(10 , function():void{ 
				mc.addFrameScript(10 , null);
				target.alpha = 0;
			});
			mc.rotation = target.rotation;
			swfEffect.startPlay();
			swfEffect.addEventListener(SwfEffectBase.SWF_EFFECT_END , bombEndHandler);
			swfEffect.x = point.x;
			swfEffect.y = point.y;
			this.addElement(swfEffect);
		}
		
		/**
		 * 设置营地数量
		 */
		public function setEncampmentNum(value:int  , isMe:Boolean):void
		{
			var string:String;
			if(value!=0){
				if(value<10){
					string = "0" + value;
				}else{
					string = value.toString();
				}
			}
			if(isMe){
				myEncampmentNumLabel.text = string;
			}else{
				enemyEncampmentNumLabel.text = string;
			}
		}
		
		/**
		 * 设置墓地数量
		 */
		public function setMDNum(value:int  , isMe:Boolean):void
		{
			var string:String;
			if(value!=0){
				if(value<10){
					string = "0" + value;
				}else{
					string = value.toString();
				}
			}
			if(isMe){
				myMDNumLabel.text = string;
			}else{
				enemyMDNumLabel.text = string;
			}
		}
		
		private var myGeneralSlotUIAsset:UIAsset;
		private var enemyGeneralSlotUIAsset:UIAsset;
		/**
		 * 主将槽破坏效果
		 */
		public function generalSlotBreak(isMe:Boolean , remove:Boolean = false):void
		{
			var uiasset:UIAsset;
			if(isMe)
				uiasset = myGeneralSlotUIAsset;
			else
				uiasset = enemyGeneralSlotUIAsset;
			if(remove){
				if(uiasset)
					this.removeElement(uiasset);
				return;
			}
			if(!uiasset){
				uiasset = new UIAsset();
				uiasset.skinName = "IMG_SlotBreak";
			}
			if(!uiasset.parent){
				this.addElement(uiasset);
			}
			uiasset.x = 153;
			if(isMe){
				myGeneralSlotUIAsset = uiasset;
				uiasset.y = 322;
			}else{
				enemyGeneralSlotUIAsset = uiasset;
				uiasset.y = 192;
			}
		}
		
		public function reset():void
		{
			setEncampmentNum(0,false);
			setEncampmentNum(0,true);
			setMDNum(0,false);
			setMDNum(0,true);
			generalSlotBreak(true,true);
			generalSlotBreak(false,true);
		}
		
		public static function getInstance():Effect3DCantainer
		{
			return CombatStage.getInstance().effect3DCantainer;
		}
	}
}