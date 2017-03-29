package utils
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Point;

	public class MatrixUtil
	{
		public function MatrixUtil()
		{
		}
		
		
		/**
		 *  令显示对象围绕其内部的变形点进行旋转，旋转角度由 angleDegress 参数指定。
		 *  @param target 要进行旋转的显示对象。
		 *  @param x 该点的 x 坐标。
		 *  @param y 该点的 y 坐标。
		 *  @param angleDegrees 以度为单位的旋转角度。
		 */
		public static function rotateAroundInternalPoint( target:DisplayObject, x:Number, y:Number, angleDegrees:Number ):void
		{
			var m:Matrix = target.transform.matrix;
			var point:Point = new Point( x, y );
			point = m.transformPoint( point );
			m.tx -= point.x;
			m.ty -= point.y;
			m.rotate( angleDegrees * Math.PI / 180 );
			m.tx += point.x;
			m.ty += point.y;
			target.transform.matrix = m;
		}
		
		public static function changeTo2D(target:DisplayObject):void
		{
			var matrix3D:Matrix3D = target.transform.matrix3D;
			if(matrix3D!=null){
				var _matrix:Matrix=new Matrix();
				_matrix.a = matrix3D.rawData[0];
				_matrix.b = matrix3D.rawData[1];
				_matrix.c = matrix3D.rawData[4];
				_matrix.d = matrix3D.rawData[5];
				_matrix.tx=matrix3D.position.x;
				_matrix.ty =matrix3D.position.y;
				target.transform.matrix=_matrix;
				target.transform.matrix3D=null;
			}
		}
	}
}