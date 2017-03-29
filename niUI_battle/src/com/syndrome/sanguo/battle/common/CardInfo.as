package com.syndrome.sanguo.battle.common
{
	import org.flexlite.domDll.Dll;
	
	import utils.ObjectUtil;

	/**
	 * 卡片信息
	 */
	public class CardInfo
	{
		private static var cardInfoObject:Object = {};
		
		public function CardInfo()
		{
		}
		
		/**
		 * 构建卡片信息
		 */
		public static function buildCardsInfo():void
		{
			var cardXML:XML = Dll.getRes("cards");
			if(!cardXML){
				throw(new Error("卡表载入失败！"));
			}
			analyzeXML(cardXML);
		}
		
		private static function analyzeXML(cardXML:XML):void
		{
			for each (var card:XML in cardXML.card) 
			{
				var id:int;
				var object:Object = {};
				for each(var ite:XML in card.children())
				{
					var name:String = ite.name().toString();
					var value:String = ite.toString();
					if(name == "id"){
						id = int(value);
						object["id"] = id;
					}else{
						object[name] = value;
					}
				}
				cardInfoObject[id] = object;
			}
		}		
		
		/**
		 * 获取卡牌的基本信息 
		 */
		public static function getCardInfoById(cardid:int):Object
		{
			if(cardInfoObject.hasOwnProperty(cardid)){
				return ObjectUtil.deepCopy(cardInfoObject[cardid]);
			}
			return {};
		}
	}
}