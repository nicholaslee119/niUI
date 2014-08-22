package com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D
{
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.property.BattleFieldConst;
	
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	import org.flexlite.domUI.components.Group;
	
	/**
	 * 卡片2D容器
	 */
	public class Card2DCantainer extends Group
	{
		public var myHandCardGroup:MyHandCardGroup;
		public var enemyHandCardGroup:EnemyHandCardGroup;
		public var battleCardGroup:BattleCardGroup;
		
		public function Card2DCantainer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			var p:PerspectiveProjection  = new PerspectiveProjection();
			p.fieldOfView = BattleFieldConst.gameCanvas_fieldOfView;
			p.projectionCenter = new Point(
				BattleFieldConst.gameCanvas_projectionCenterX,BattleFieldConst.gameCanvas_projectionCenteY
			);
			this.transform.perspectiveProjection  = p;
			myHandCardGroup = new MyHandCardGroup();
			this.addElement(myHandCardGroup);
			
			enemyHandCardGroup = new EnemyHandCardGroup();
			this.addElement(enemyHandCardGroup);
			
			battleCardGroup = new BattleCardGroup();
			this.addElement(battleCardGroup);
		}
		
		public static function getInstance():Card2DCantainer
		{
			return CombatStage.getInstance().card2DCantainer;
		}
	}
}