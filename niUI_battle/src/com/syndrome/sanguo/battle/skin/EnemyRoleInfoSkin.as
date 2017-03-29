package com.syndrome.sanguo.battle.skin
{
	import com.syndrome.sanguo.battle.skin.SimpleProgressSkin;
	import flash.filters.GlowFilter;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.ProgressBar;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class EnemyRoleInfoSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var bloodMask:org.flexlite.domUI.components.Rect;

		public var bloodUI:org.flexlite.domUI.components.UIAsset;

		public var crisisMC:org.flexlite.domUI.components.UIMovieClip;

		public var glowFilter:flash.filters.GlowFilter;

		public var handNumLabel:org.flexlite.domUI.components.Label;

		public var hpLabel:org.flexlite.domUI.components.Label;

		public var nameLabel:org.flexlite.domUI.components.Label;

		public var rectMask:org.flexlite.domUI.components.Rect;

		public var roleIconUI:org.flexlite.domUI.components.UIAsset;

		public var timeOutFlagGroup:org.flexlite.domUI.components.Group;

		public var turnMC:org.flexlite.domUI.components.UIMovieClip;

		public var turnTimeLabel:org.flexlite.domUI.components.Label;

		public var turnTimeUI:org.flexlite.domUI.components.ProgressBar;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function EnemyRoleInfoSkin()
		{
			super();
			
			this.currentState = "normal";
			glowFilter_i();
			this.elementsContent = [roleIconUI_i(),rectMask_i(),turnTimeLabel_i(),__EnemyRoleInfoSkin_UIAsset1_i(),bloodUI_i(),bloodMask_i(),hpLabel_i(),__EnemyRoleInfoSkin_UIAsset2_i(),nameLabel_i(),__EnemyRoleInfoSkin_UIAsset3_i(),handNumLabel_i(),timeOutFlagGroup_i(),turnTimeUI_i(),turnMC_i(),crisisMC_i()];
			
			states = [
				new org.flexlite.domUI.states.State ({name: "normal",
					overrides: [
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "disabled",
					overrides: [
					]
				})
			];
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function __EnemyRoleInfoSkin_HorizontalLayout1_i():org.flexlite.domUI.layouts.HorizontalLayout
		{
			var temp:org.flexlite.domUI.layouts.HorizontalLayout = new org.flexlite.domUI.layouts.HorizontalLayout();
			temp.gap = 0;
			return temp;
		}

		private function __EnemyRoleInfoSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.horizontalCenter = 0;
			temp.skinName = "IMG_RoleInfo_EnemyBackGround";
			temp.y = 0;
			return temp;
		}

		private function __EnemyRoleInfoSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.height = 19;
			temp.horizontalCenter = 0;
			temp.skinName = "IMG_RoleInfo_BloodHighLight";
			temp.verticalCenter = 68.5;
			temp.width = 100;
			return temp;
		}

		private function __EnemyRoleInfoSkin_UIAsset3_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.includeInLayout = false;
			temp.skinName = "IMG_RoleInfo_HandNum";
			temp.x = -29;
			temp.y = 1;
			return temp;
		}

		private function __EnemyRoleInfoSkin_UIAsset4_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.skinName = "IMG_RoleInfo_TimeOutFlag";
			temp.x = 71;
			temp.y = 3;
			return temp;
		}

		private function __EnemyRoleInfoSkin_UIAsset5_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.skinName = "IMG_RoleInfo_TimeOutFlag";
			temp.x = 67;
			temp.y = 3;
			return temp;
		}

		private function __EnemyRoleInfoSkin_UIAsset6_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.skinName = "IMG_RoleInfo_TimeOutFlag";
			temp.x = 71;
			temp.y = 3;
			return temp;
		}

		private function bloodMask_i():org.flexlite.domUI.components.Rect
		{
			var temp:org.flexlite.domUI.components.Rect = new org.flexlite.domUI.components.Rect();
			bloodMask = temp;
			temp.height = 19;
			temp.left = 6;
			temp.verticalCenter = 68.5;
			temp.width = 100;
			if(bloodUI)
			{
				bloodUI.mask = bloodMask;
			}
			return temp;
		}

		private function bloodUI_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			bloodUI = temp;
			temp.height = 19;
			temp.left = 6;
			temp.mask = bloodMask;
			temp.skinName = "IMG_RoleInfo_Blood";
			temp.verticalCenter = 68.5;
			temp.width = 100;
			return temp;
		}

		private function crisisMC_i():org.flexlite.domUI.components.UIMovieClip
		{
			var temp:org.flexlite.domUI.components.UIMovieClip = new org.flexlite.domUI.components.UIMovieClip();
			crisisMC = temp;
			temp.includeInLayout = false;
			temp.skinName = "Effect_Crisis";
			temp.x = 6;
			temp.y = 134;
			return temp;
		}

		private function glowFilter_i():flash.filters.GlowFilter
		{
			var temp:flash.filters.GlowFilter = new flash.filters.GlowFilter();
			glowFilter = temp;
			temp.blurX = 6;
			temp.blurY = 6;
			temp.color = 0xF5A87E;
			temp.quality = 3;
			temp.strength = 1.3;
			return temp;
		}

		private function handNumLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			handNumLabel = temp;
			temp.bold = true;
			temp.includeInLayout = false;
			temp.size = 15;
			temp.text = "0/7";
			temp.textColor = 0xffffff;
			temp.x = -25;
			temp.y = 13;
			return temp;
		}

		private function hpLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			hpLabel = temp;
			temp.filters = [glowFilter];
			temp.fontFamily = "Arial";
			temp.height = 19;
			temp.horizontalCenter = 0;
			temp.size = 14;
			temp.text = "30/30";
			temp.textAlign = "center";
			temp.textColor = 0xffffff;
			temp.verticalAlign = "middle";
			temp.verticalCenter = 68.5;
			temp.width = 100;
			return temp;
		}

		private function nameLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			nameLabel = temp;
			temp.height = 16;
			temp.horizontalCenter = -0.5;
			temp.textAlign = "center";
			temp.textColor = 0xffffff;
			temp.verticalAlign = "middle";
			temp.verticalCenter = 47;
			temp.width = 105;
			return temp;
		}

		private function rectMask_i():org.flexlite.domUI.components.Rect
		{
			var temp:org.flexlite.domUI.components.Rect = new org.flexlite.domUI.components.Rect();
			rectMask = temp;
			temp.bottomLeftRadius = 64;
			temp.bottomRightRadius = 64;
			temp.height = 100;
			temp.horizontalCenter = 0;
			temp.topLeftRadius = 64;
			temp.topRightRadius = 64;
			temp.width = 100;
			temp.y = 5;
			if(roleIconUI)
			{
				roleIconUI.mask = rectMask;
			}
			return temp;
		}

		private function roleIconUI_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			roleIconUI = temp;
			temp.height = 100;
			temp.horizontalCenter = 0;
			temp.mask = rectMask;
			temp.width = 100;
			temp.y = 5;
			return temp;
		}

		private function timeOutFlagGroup_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			timeOutFlagGroup = temp;
			temp.bottom = 50;
			temp.horizontalCenter = 0;
			temp.layout = __EnemyRoleInfoSkin_HorizontalLayout1_i();
			temp.elementsContent = [__EnemyRoleInfoSkin_UIAsset4_i(),__EnemyRoleInfoSkin_UIAsset5_i(),__EnemyRoleInfoSkin_UIAsset6_i()];
			return temp;
		}

		private function turnMC_i():org.flexlite.domUI.components.UIMovieClip
		{
			var temp:org.flexlite.domUI.components.UIMovieClip = new org.flexlite.domUI.components.UIMovieClip();
			turnMC = temp;
			temp.height = 104;
			temp.includeInLayout = false;
			temp.skinName = "Effect_TurnTime";
			temp.width = 108;
			temp.x = 57;
			temp.y = 55;
			return temp;
		}

		private function turnTimeLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			turnTimeLabel = temp;
			temp.bold = true;
			temp.filters = [glowFilter];
			temp.fontFamily = "SimHei";
			temp.height = 50;
			temp.horizontalCenter = 0;
			temp.size = 50;
			temp.textAlign = "center";
			temp.textColor = 0xffffff;
			temp.verticalAlign = "middle";
			temp.verticalCenter = -22;
			temp.width = 50;
			return temp;
		}

		private function turnTimeUI_i():org.flexlite.domUI.components.ProgressBar
		{
			var temp:org.flexlite.domUI.components.ProgressBar = new org.flexlite.domUI.components.ProgressBar();
			turnTimeUI = temp;
			temp.height = 3;
			temp.horizontalCenter = 0.5;
			temp.maximum = 100;
			temp.skinName = com.syndrome.sanguo.battle.skin.SimpleProgressSkin;
			temp.slideDuration = 0;
			temp.stepSize = 0.1;
			temp.value = 100;
			temp.width = 103;
			temp.y = 109;
			return temp;
		}

	}
}