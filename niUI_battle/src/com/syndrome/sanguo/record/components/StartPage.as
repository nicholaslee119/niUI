package com.syndrome.sanguo.record.components
{
	import com.syndrome.sanguo.record.RecordSystem;
	import com.syndrome.sanguo.record.components.skin.StartPageSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Alert;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.DropDownList;
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.components.TextInput;
	
	public class StartPage extends SkinnableComponent
	{
		public var loadButton:Button;
		public var pathTextInput:TextInput;
		public var playerDropDownList:DropDownList;
		public var startButton:Button;

		public function StartPage()
		{
			super();
			this.skinName = StartPageSkin;
		}
		
		/**
		 * 通过路径加载
		 */
		public function setPath(path:String):void
		{
			this.visible = true;
			this.loadButton.enabled = false;
			
			var uq:URLRequest = new URLRequest(path);
			var loader:URLLoader  = new URLLoader(uq);
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE , function(event:Event):void{
				loadButton.enabled = true;
				loadComplete(path , loader.data as ByteArray);
			});
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			loadButton.addEventListener(MouseEvent.CLICK , loadScript);
			startButton.addEventListener(MouseEvent.CLICK , startClick);
		}
		
		protected function startClick(event:MouseEvent):void
		{
			if(playerDropDownList.dataProvider && playerDropDownList.dataProvider.length > 0){
				var arr:Array = RecordSystem.getInstance().getScript("record");
				if(playerDropDownList.selectedIndex == 0)
				{
					arr[0]["message"]["isMe"] = true;
					arr[1]["message"]["isMe"] = false;
				}
				else
				{
					arr[0]["message"]["isMe"] = false;
					arr[1]["message"]["isMe"] = true;
				}
				this.dispatchEvent(new Event("start"));
			}
			else
			{
				Alert.show("请先载入录像文件！");
			}
		}
		
		protected function loadScript(event:MouseEvent):void
		{
			var fr:FileReference = new FileReference();
			fr.addEventListener(Event.SELECT , function(event:Event):void{
				fr.addEventListener(Event.COMPLETE , function():void{
					loadComplete(fr.name , fr.data);
				});
				fr.load();
			});
			fr.browse([new FileFilter("三国智录像(.record)", "*.record")]);
		}
		
		private function loadComplete(fileName:String , data:ByteArray):void
		{
			pathTextInput.text = fileName;
			RecordSystem.getInstance().init({"record":data});
			parseUserName();
		}
		
		/**
		 * 解析用户名
		 */
		private function parseUserName():void
		{
			var arr:Array = RecordSystem.getInstance().getScript("record");
			var player1:String =  arr[0]["message"]["gui"]["nickname"];
			var player2:String =  arr[1]["message"]["gui"]["nickname"];
			playerDropDownList.dataProvider = new ArrayCollection([player1 , player2]);
			playerDropDownList.selectedIndex = 0;
		}
	}
}