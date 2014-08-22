package components
{
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.IItemRenderer;
	import org.flexlite.domUI.components.List;
	import org.flexlite.domUI.core.IVisualElement;
	
	/**
	 * 改变了多选样式的List组件
	 */
	public class MultipleSelectionList extends List
	{
		public function MultipleSelectionList()
		{
			super();
			this.allowMultipleSelection = true;
		}
		
		/**
		 * 鼠标在项呈示器上按下
		 */		
		override protected function item_mouseDownHandler(event:MouseEvent):void
		{
			var oldSelectedIndices:Vector.<int> = new Vector.<int>;
			for (var i:int = 0; i < selectedIndices.length; i++) 
			{
				oldSelectedIndices.push(selectedIndices[i]);
			}
			var itemRenderer:IItemRenderer = event.currentTarget as IItemRenderer;
			var newIndex:int;
			if (itemRenderer)
				newIndex = itemRenderer.itemIndex;
			else
				newIndex = dataGroup.getElementIndex(event.currentTarget as IVisualElement);
			
			var hasSelectedIndex:int = selectedIndices.indexOf(newIndex);
			super.item_mouseDownHandler(event);
			if(allowMultipleSelection)
			{
				if(hasSelectedIndex>=0)
				{
					if(requireSelection || oldSelectedIndices.length > 1){
						oldSelectedIndices.splice(hasSelectedIndex , 1);
					}
				}else
				{
					oldSelectedIndices.splice(0,0,newIndex);
				}
				selectedIndices = oldSelectedIndices;
			}
		}
	}
}