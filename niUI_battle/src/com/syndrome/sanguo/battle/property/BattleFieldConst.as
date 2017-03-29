package com.syndrome.sanguo.battle.property
{
	public class BattleFieldConst
	{
		public static const stage_width:Number  = 1280;
		public static const stage_height:Number  = 700;
		
		public static const gameCanvas_fieldOfView:Number  = 30;
		public static const gameCanvas_width:Number  = 954;
		public static const gameCanvas_projectionCenterX:Number  = 477;
		public static const  gameCanvas_projectionCenteY:Number  = 350;
		
		public static const  card3DCanvas_fieldOfView:Number  = 30;
		public static const  card3DCanvas_projectionCenterX:Number  = gameCanvas_projectionCenterX;
		public static const  card3DCanvas_projectionCenterY:Number  = 259;
		public static const  card3DCanvas_rotationX:Number  = -24;
		public static const  group3DCanvas_x:Number  = 20;
		public static const  group3DCanvas_y:Number  = 500;
		public static const  group3DChild_y:Number = -518;
		public static const  group3DChild_width:Number = 908;

		public static const  enemyHandCanvas_z:Number  = 234;
		public static const  myHandCanvas_z:Number  = -30;

		
		public function BattleFieldConst()
		{
		}
	}
}