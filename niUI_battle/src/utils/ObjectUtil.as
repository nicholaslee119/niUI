package utils
{
	import flash.display.DisplayObject;
	import flash.net.LocalConnection;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.flexlite.domUI.collections.ArrayCollection;

	public class ObjectUtil
	{
		public function ObjectUtil()
		{
		}
		
		/**
		 * 将obj1 和 obj2 的属性合并进入obj1中,如果有相同的属性则不合并
		 * @param object1
		 * @param object2
		 * 
		 */
		public static function concat(object1:Object , object2:Object):void
		{
			for(var str:String in object2){
				if(!object1.hasOwnProperty(str)){
					object1[str] = object2[str];
				}
			}
		}
		
		/**
		 * 深拷贝,对于Function或可视化对象实现的是浅拷贝
		 * 注意：ObjectUtil.copy是无法拷贝Function或可视化对象的
		 */ 
		public static function deepCopy(obj:Object):Object{
			if(!obj)
				return null;
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(obj);
			bytes.position = 0;
			return bytes.readObject();
//			if(obj == null||obj is String||obj is Number||obj is Boolean||obj is Function||obj is DisplayObject){
//				return obj;
//			}else if(obj is ByteArray){
//				var buffer:ByteArray = new ByteArray();
//				buffer.writeObject(obj);
//				buffer.position = 0;
//				var result:Object = buffer.readObject();
//				return result;
//			}else if(obj is Array){
//				var newArray:Array=new  Array();
//				var arraylen:int=obj.length;
//				for(var i1:int=0;i1<arraylen;i1++){
//					newArray.push(deepCopy(obj[i1]));
//				}
//				return newArray;
//			}else if(obj is ArrayCollection){
//				var newArrayList:ArrayCollection=new  ArrayCollection();
//				var arrayListlen:int=obj.length;
//				for(var i2:int=0;i2<arrayListlen;i2++){
//					newArrayList.addItem(deepCopy(obj.getItemAt(i2)));
//				}
//				return newArrayList;
//			}else if((typeof obj) is Vector){
//				var newVector:Vector=new  Vector();
//				var vectorlen:int=obj.length;
//				for(var i3:int=0;i3<vectorlen;i3++){
//					newVector.push(deepCopy(obj[i3]));
//				}
//				return newVector;
//			}else{
//				var newObj:Object=new (getDefinitionByName(getQualifiedClassName(obj)) as Class)();
//				for(var f:String in obj){
//					newObj[f]=deepCopy(obj[f]);
//				}
//				return newObj;
//			}
		}
		
		/**
		 * 黑科技，垃圾回收器
		 */
		public static function gc():void
		{
			try{
				new LocalConnection().connect("GC");
				new LocalConnection().connect("GC");
			}catch(error : Error){
			}
		}
	}
}