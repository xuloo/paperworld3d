package examples
{
	import com.paperworld.rpc.objects.Avatar;
	import com.paperworld.rpc.objects.Behaviour3D;
	import com.paperworld.rpc.objects.Proxy;
	import com.paperworld.rpc.objects.RemoteObject;
	import com.paperworld.rpc.smoothers.AbstractSmoother;
	import com.paperworld.rpc.smoothers.Smoother3D;
	
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	
	public class SimpleAvatar extends Avatar
	{
		public function SimpleAvatar()
		{
		}
		
		override protected function initialise():void 
		{
			super.initialise();
			
			behaviour = new Behaviour3D();
			
			var material:ColorMaterial = new ColorMaterial(0xffcc33);
			material.doubleSided = true;
			
			var model:DisplayObject3D = new Plane(material, 250, 250);
			avatar = new RemoteObject(model);
			
			var smoother:AbstractSmoother = new Smoother3D();
			smoother.target = avatar;
			
			avatar.smoother = smoother;
			
			addChild(model);
		}
		
		override protected function createCharacter():void
		{
			//super.createCharacter();
			var material:ColorMaterial = new ColorMaterial(0x00ff00);
			material.doubleSided = true;
			character = new RemoteObject( new Plane(material, 300, 300));
			addChild(character.displayObject);
			
			character.smoother = new Smoother3D();
			character.smoother.target = character;
		}
		
		override protected function createProxy():void
		{
			var material:ColorMaterial = new ColorMaterial(0xff0000);
			material.doubleSided = true;
			proxy = new Proxy( new Plane(material, 300, 300));
			addChild(proxy.displayObject);
		}
	}
}