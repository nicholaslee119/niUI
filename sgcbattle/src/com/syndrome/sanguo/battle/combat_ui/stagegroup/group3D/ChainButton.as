package com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D
{
	import com.syndrome.sanguo.battle.skin.button.ChainButtonSkin;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	
	/**
	 * 连环按钮
	 */
	public class ChainButton extends Button
	{
		public var chainTypeLabel:Label;
		public var cardNameLabel:Label;
		public var backGround:UIAsset;
		
		public function ChainButton()
		{
			super();
			this.skinName = ChainButtonSkin;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(instance == chainTypeLabel){
				chainTypeLabel.text = chainTypeText;
			}else if(instance == cardNameLabel){
				cardNameLabel.text = cardNameText;
			}else if(instance == backGround){
				setBackGround();
			}
		}
		
		private var _isMe:Boolean;
		/**
		 * 是否我方
		 */
		public function get isMe():Boolean
		{
			return _isMe;
		}

		public function set isMe(value:Boolean):void
		{
			_isMe = value;
			if(backGround){
				setBackGround();
			}
		}
		
		private function setBackGround():void
		{
			if(isMe)
				backGround.skinName = "IMG_Chain_MyBackGround";
			else
				backGround.skinName = "IMG_Chain_EnemyBackGround";
		}
		

		private var _chainTypeText:String;
		/**
		 * 连环类型文本
		 */
		public function get chainTypeText():String
		{
			return _chainTypeText;
		}

		public function set chainTypeText(value:String):void
		{
			_chainTypeText = value;
			if(chainTypeLabel){
				chainTypeLabel.text = value;
			}
		}

		private var _cardNameText:String;
		/**
		 * 卡片名文本
		 */
		public function get cardNameText():String
		{
			return _cardNameText;
		}

		public function set cardNameText(value:String):void
		{
			_cardNameText = value;
			if(cardNameLabel){
				cardNameLabel.text = value;
			}
		}
	}
}