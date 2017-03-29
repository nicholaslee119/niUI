package com.syndrome.sanguo.battle.skin
{
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.AddItems;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class DistributeInjuryIconSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var __DistributeInjuryIconSkin_UIAsset2:org.flexlite.domUI.components.UIAsset;

		public var __DistributeInjuryIconSkin_UIAsset3:org.flexlite.domUI.components.UIAsset;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function DistributeInjuryIconSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [__DistributeInjuryIconSkin_UIAsset1_i()];
			__DistributeInjuryIconSkin_UIAsset2_i();
			__DistributeInjuryIconSkin_UIAsset3_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "normal",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__DistributeInjuryIconSkin_UIAsset2",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
						,
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__DistributeInjuryIconSkin_UIAsset3",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "disabled",
					overrides: [
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "attack",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__DistributeInjuryIconSkin_UIAsset3",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "defend",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__DistributeInjuryIconSkin_UIAsset2",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "attacked",
					overrides: [
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "defended",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__DistributeInjuryIconSkin_UIAsset2",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
						,
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__DistributeInjuryIconSkin_UIAsset3",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
			];
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function __DistributeInjuryIconSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.skinName = "IMG_DistributeInjury_IconBackGround";
			return temp;
		}

		private function __DistributeInjuryIconSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__DistributeInjuryIconSkin_UIAsset2 = temp;
			temp.skinName = "IMG_DistributeInjury_IconDenfense";
			return temp;
		}

		private function __DistributeInjuryIconSkin_UIAsset3_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__DistributeInjuryIconSkin_UIAsset3 = temp;
			temp.skinName = "IMG_DistributeInjury_IconAttack";
			return temp;
		}

	}
}