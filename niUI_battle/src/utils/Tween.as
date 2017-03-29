package utils
{
	import org.flexlite.domUI.effects.animation.Animation;
	import org.flexlite.domUI.effects.animation.MotionPath;

	/**
	 * 缓动工具类
	 */
	public class Tween
	{
		public function Tween()
		{
		}
		
		/**
		 * @param target 要缓动的目标
		 * @param duration 缓动时间  毫秒为单位
		 * @param vars 要缓动的属性 ，特殊属性 onComplete:Function 缓动完成执行的方法 onCompleteParams:Array 缓动完成执行方法的参数列表 easer:IEaser 缓动行为
		 */
		public static function to(target:Object, duration:Number, vars:Object):void
		{
			var updateValue:Function = function(animation:Animation):void
			{
				for (var str:String in animation.currentValue) 
				{
					target[str] = animation.currentValue[str];
				}
			};
			
			var endFunction:Function = function(animation:Animation):void
			{
				if(complete != null){
					if(completeArgs){
						complete.apply(null , completeArgs);
					}else{
						complete();
					}
				}
			}
			 var animation:Animation = new Animation(updateValue);
			 var vector:Vector.<MotionPath> = new Vector.<MotionPath>();
			 var complete:Function;
			 var completeArgs:Array;
			 for (var str:String in vars) 
			 {
				 if(str == "onComplete"){
					 complete = vars["onComplete"];
				 }else if(str == "onCompleteParams"){
					 completeArgs =  vars["onCompleteParams"];
				 }else if(str == "easer"){
					 animation.easer = vars["easer"];
				 }else{
					 vector.push(new MotionPath(str , target[str] , vars[str]));
				 }
			 }
			 animation.duration = duration;
			 animation.endFunction = endFunction;
			 animation.motionPaths = vector;
			 animation.play();
		}
	}
}