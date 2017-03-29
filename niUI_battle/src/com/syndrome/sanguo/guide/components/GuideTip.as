package com.syndrome.sanguo.guide.components
{
	import com.syndrome.sanguo.battle.skin.guide.GuideTipSkin;
	
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.components.UIAsset;

	public class GuideTip extends SkinnableComponent
	{
		public var iconUIAsset:UIAsset;
		public var contentLabel:Label;
		
		public function GuideTip()
		{
			super();
			this.includeInLayout = false;
			this.skinName = GuideTipSkin;
		}
		
		private var _content:String;
		/**
		 * 文本内容
		 */
		public function get content():String
		{
			return _content;
		}
		
		public function set content(value:String):void
		{
			if(_content == value)
				return;
			_content = value;
			invalidateProperties();
		}
		
		private var _iconPath:String;

		/**
		 * 图片路径
		 */
		public function get iconPath():String
		{
			return _iconPath;
		}

		public function set iconPath(value:String):void
		{
			if(_iconPath == value)
				return;
			_iconPath = value;
			invalidateProperties();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			iconUIAsset.skinName = iconPath;
			contentLabel.text = content;
		}
	}
}