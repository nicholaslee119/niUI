package com.syndrome.sanguo.battle.combat_ui.window
{
	import com.syndrome.sanguo.battle.skin.DistributeInjuryIconSkin;
	
	import org.flexlite.domUI.components.SkinnableComponent;
	
	public class DistributeInjuryIcon extends SkinnableComponent
	{
		private var _currentState:int = 3;
		
		public function DistributeInjuryIcon()
		{
			super();
			this.skinName = DistributeInjuryIconSkin;
		}
		
		/**
		 * 当前显示状态  , 1表示进攻 ，2表示防守，3表示已进攻，4表示已防守
		 */
		public function get currentState():int
		{
			return _currentState;
		}
		
		public function set currentState(value:int):void
		{
			if(_currentState == value){
				return;
			}
			_currentState = value;
			invalidateSkinState();
		}
		
		override protected function getCurrentSkinState():String
		{
			if (!enabled)
				return super.getCurrentSkinState();
			
			switch(currentState){
				case 1:
					return "attack";
				case 2:
					return "defend";
				case 3:
					return "attacked";
				case 4:
					return "defended";
			}
			return super.getCurrentSkinState();
		}
	}
}