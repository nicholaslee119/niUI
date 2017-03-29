package com.syndrome.sanguo.battle.combat_ui
{
	import app.config.AppConfig;
	
	import com.syndrome.sanguo.battle.skin.CardInfoGroupSkin;
	
	import flash.display.BitmapData;
	
	import org.flexlite.domDll.Dll;
	import org.flexlite.domUI.components.SkinnableContainer;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	
	public class CardInfoGroup extends SkinnableContainer
	{
		/**
		 * 卡图
		 */
		private var cardImage:UIAsset;
		
		/**
		 * 加载部件
		 */
		private var loading:UIMovieClip;
		
		public function CardInfoGroup()
		{
			super();
			this.skinName = CardInfoGroupSkin;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			cardImage = new UIAsset();
			cardImage.verticalCenter = 0;
			cardImage.horizontalCenter = 0;
			this.addElement(cardImage);
			
			loading = new UIMovieClip();
			loading.verticalCenter = 0;
			loading.horizontalCenter = 0;
			loading.skinName = "UI_Loading";
			this.addElement(loading);
			showLoading(false);
		}
		
		private function showLoading(b:Boolean):void
		{
			if(b){
				loading.visible = true;
				loading.gotoAndPlay(1);
			}else{
				loading.visible = false;
				loading.stop();
			}
		}
		
		public function showCard(id:String):void
		{
			if(int(id)<=0){
				return;
			}
			showLoading(true);
			Dll.getResByUrl(AppConfig.bigCardFolder + id +AppConfig.bigCardType,function(data:BitmapData):void{
				showLoading(false);
				cardImage.skinName = data;
			});
		}
		
		public function reset():void
		{
			cardImage.skinName = null;
		}
		
		public static function getInstance():CardInfoGroup
		{
			return CombatGroup.getInstance().cardInfoGroup;
		}
	}
}