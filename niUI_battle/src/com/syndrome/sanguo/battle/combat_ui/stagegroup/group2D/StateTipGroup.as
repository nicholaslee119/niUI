package com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D
{
	import flash.events.Event;
	
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.utils.callLater;
	
	import com.syndrome.sanguo.battle.skin.StateTipSkin;
	
	public class StateTipGroup extends SkinnableComponent
	{
		public var stateMC:UIMovieClip;
		public var currentRound:Label;
		
		public function StateTipGroup()
		{
			super();
			this.skinName = StateTipSkin;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(instance == stateMC){
				stateMC.gotoAndStop(0);
			}
		}
		
		public function setState(gameState:int , isMyTurn:Boolean , roundIndex:int):void
		{
			var frame:int;
			if(isMyTurn){
				frame = gameState-1;
			}else{
				frame = gameState+3;
			}
			stateMC.gotoAndStop(frame);
			currentRound.text = roundIndex.toString();
		}
	}
}