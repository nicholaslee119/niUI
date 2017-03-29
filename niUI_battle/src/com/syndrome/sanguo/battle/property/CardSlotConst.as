package com.syndrome.sanguo.battle.property
{
	import flash.geom.Point;

	public class CardSlotConst
	{
		/**
		 * 手牌槽 0
		 */
		public static const  handCardSlot:int = 0;
		
		/**
		 * 兵权槽 1
		 */
		public static const  militaryCardSlot:int = 1;
		
		/**
		 * 谋略槽 2
		 */
		public static const  strategyCardSlot:int = 2;
		
		/**
		 * 事件槽 3
		 */
		public static const  incidentCardSlot:int = 3;
		
		/**
		 * 武将槽 4
		 */
		public static const  generalCardSlot:int = 4;
		
		/**
		 * 营地 5
		 */
		public static const  encampmentCardSlot:int = 5;
		
		/**
		 * 墓地 6
		 */
		public static const  graveyardCardSlot:int = 6;
		
		/**
		 * 宝物槽 7
		 */
		public static const  equipmentCardSlot:int = 7;
		
		/**
		 * 阵型槽 8
		 */
		public static const  phalanxCardSlot:int = 8;
		
		
		/**
		 * 我方卡槽的初始点
		 */
		public static const  my_SlotPoint:Array =
			[
				new Point(321,618),new Point(57,-198),new Point(248,-71),new Point(152,-71),
				new Point(152,-198),new Point(758,-71),new Point(56,-71),new Point(152,-198),new Point(758,-198)
			];
		
		/**
		 * 敌方卡槽的初始点
		 */
		public static const  enemy_SlotPoint:Array =
			[
				new Point(170,-70),new Point(57,-330),new Point(248,-455),new Point(152,-456),
				new Point(152,-330),new Point(758,-456),new Point(56,-455),new Point(152,-330),new Point(758,-330)
			];
		
		/**
		 * 连环槽的位置
		 */
		public static const  chainPoint:Point = new Point(810,-62);
		
		public function CardSlotConst()
		{
		}
	}
}