package com.syndrome.sanguocard.mainfram.main
{
	import com.syndrome.sanguocard.mainfram.ui.UILoading;

	public class MainLoadHandler extends MainHandlerBase
	{
		public var uiLoading:UILoading;
		
		public function MainLoadHandler(_main:Main)
		{
			super(_main);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			uiLoading = new UILoading(main);
		}
		
		internal function onResBattleProgress(pros:Number):void
		{
			pros = 0.5 + pros/2;
			uiLoading.pros(pros);
			main.esRoomManager.mainDispatchPros(pros);
		}
		
		internal function onSceneBattleProgress(pros:Number):void
		{
			uiLoading.pros(pros);
			main.esRoomManager.mainDispatchPros(pros);
		}
		
		internal function onResLoadComplete():void
		{
			uiLoading.pros(1);
			main.esRoomManager.mainDispatchPros(1);
		}
		
		internal function onGetOpPros(pros:Number):void
		{
			uiLoading.opPros(pros);
		}
		
		internal function hideUILoading():void
		{
			uiLoading.ui.visible = false;
		}
		
		internal function showUILoading():void
		{
			uiLoading.ui.visible = true;
		}
		
		internal function initLoading():void
		{
			uiLoading.init();
		}
		
		internal function initOpDone():void
		{
			uiLoading.initOpDone();
		}
		
		internal function getUILoadingDisplayStatus():Boolean
		{
			return uiLoading.ui.visible;
		}
	}
}