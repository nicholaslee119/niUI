package com.syndrome.sanguo.battle.property
{
	public class CardConst
	{
		/**
		 * 宽度
		 */
		public static const  width:Number = 81;
		
		/**
		 * 高度
		 */
		public static const  height:Number = 110;
		
		/**
		 * 正放 1
		 */
		public static const  state_front:int = 1;
		
		/**
		 * 盖放 2
		 */
		public static const  state_back:int = 2;

		/**
		 * 横置 3
		 */
		public static const  state_transverse:int = 3;
		
		/**
		 * 横置盖放 4
		 */
		public static const  state_transverse_back:int = 4;
		
		/**
		 * 在连环中 5
		 */
		public static const  state_link:int = 5;
		
		/**
		 * 横置在连环中 6
		 */
		public static const  state_transverse_link:int = 6;
		
		/**
		 * 盖放在连环中 7
		 */
		public static const  state_back_link:int = 7;
		
		/**
		 * 阵亡 8
		 */
		public static const  state_dead:int = 8;
		
		/**
		 * 破坏 9
		 */
		public static const  state_break:int = 9;
		
		/**
		 * 移除游戏 10
		 */
		public static const  state_moveout:int = 10;

		public function CardConst()
		{
		}
	}
}