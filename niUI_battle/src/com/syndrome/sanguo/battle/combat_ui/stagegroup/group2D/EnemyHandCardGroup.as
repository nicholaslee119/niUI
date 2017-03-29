package com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D
{
	import com.syndrome.sanguo.battle.property.BattleFieldConst;
	
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.IVisualElement;
	
	public class EnemyHandCardGroup extends Group
	{
		public function EnemyHandCardGroup()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			this.z = BattleFieldConst.enemyHandCanvas_z;
		}
		
		override public function addElementAt(element:IVisualElement, index:int):IVisualElement
		{
			var point:Point;
			var point2:Point;
			if (element.parent!=null)
			{
				element.x = element.x +element.width/2;
				element.y = element.y + element.height/2;
				point = new Point(element.x, element.y);
				point2 = globalToLocal(element.parent.localToGlobal(point));
				element.x = point2.x - element.width/2;
				element.y = point2.y - element.height/2;
			}
			return super.addElementAt(element , index);
		}
	}
}