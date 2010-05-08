package tests
{
  import asunit.framework.TestCase;
	
	import src.*;

	public class HueTest extends TestCase 
	{
		private var instance:Hue;
		
 		public function HueTest(testMethod:String) 
		{
 			super(testMethod);
 		}

		protected override function setUp():void 
		{
	 		this.instance = new Hue(new HueOptions);
	 	}
		
		protected override function tearDown():void
		{
			this.instance = null;
		}
		
		public function testLABConsistance():void
		{
			const ITERATIONS:uint = 2000, TOLERANCE:Number = 1 / 100000;
			
			var i:uint;
			
			var lab:Object = {}, xyz:Object = {}, rgb:Object = {};
			for(i = 0; i < ITERATIONS; i++)
      {
        lab = {l: 0, a: 0, b: 0};
        lab.l = HueScale.change(i, 0, ITERATIONS - 1, 0, 100);
        xyz = Hue.convertLABToXYZ(lab);
        rgb = Hue.convertXYZToRGB(xyz);
        assertEqualsFloat(rgb.r, rgb.g, TOLERANCE);
        assertEqualsFloat(rgb.g, rgb.b, TOLERANCE);
      }
		}
		
	  public function testConversionRGBXYZ():void
	  {
	  	const ITERATIONS:uint = 1000, TOLERANCE:Number = 1 / 100000;
	  	
	  	var i:uint;
	  	
	  	var rgb:Object = {}, xyz:Object = {}, crgb:Object = {}, cxyz:Object = {};
	  	for(i = 0; i < ITERATIONS; i++)
	  	{
	  		rgb.r = Math.random();
	  		rgb.g = Math.random();
	  		rgb.b = Math.random();
	  		xyz = Hue.convertRGBToXYZ(rgb);
	  		crgb = Hue.convertXYZToRGB(xyz);
	  		assertEqualsFloat(rgb.r, crgb.r, TOLERANCE);
	  		assertEqualsFloat(rgb.g, crgb.g, TOLERANCE);
	  		assertEqualsFloat(rgb.b, crgb.b, TOLERANCE);
	  	}
	  	
	  	for(i = 0; i < ITERATIONS; i++)
	  	{
	  		xyz.x = Math.random();
	  		xyz.y = Math.random();
	  		xyz.z = Math.random();
	  		rgb = Hue.convertXYZToRGB(xyz);
	  		cxyz = Hue.convertRGBToXYZ(rgb);
	  		assertEqualsFloat(xyz.x, cxyz.x, TOLERANCE);
	  		assertEqualsFloat(xyz.y, cxyz.y, TOLERANCE);
	  		assertEqualsFloat(xyz.z, cxyz.z, TOLERANCE);
	  	}
	  	
	  }
	  
	  public function testConversionXYZLAB():void
	  {
	  	const ITERATIONS:uint = 10000, TOLERANCE:Number = 1 / 100000;
	  	
	  	var i:uint;
	  	
	  	var lab:Object = {}, xyz:Object = {}, clab:Object = {}, cxyz:Object = {};
	  	for(i = 0; i < ITERATIONS; i++)
	  	{
	  		xyz.x = Math.random();
	  		xyz.y = Math.random();
	  		xyz.z = Math.random();
	  		lab = Hue.convertXYZToLAB(xyz);
	  		cxyz = Hue.convertLABToXYZ(lab);
	  		assertEqualsFloat(xyz.x, cxyz.x, TOLERANCE);
        assertEqualsFloat(xyz.y, cxyz.y, TOLERANCE);
        assertEqualsFloat(xyz.z, cxyz.z, TOLERANCE);
	  	}
	  }
	  
	  public function testConversionRGBHSL():void
    {
      const ITERATIONS:uint = 1000, TOLERANCE:Number = 1 / 100000;
      
      var i:uint;
      
      var hsl:Object = {}, rgb:Object = {}, chsl:Object = {}, crgb:Object = {};
      for(i = 0; i < ITERATIONS; i++)
      {
        rgb.r = Math.random();
        rgb.g = Math.random();
        rgb.b = Math.random();
        hsl = Hue.convertRGBToHSL(rgb);
        crgb = Hue.convertHSLToRGB(hsl);
        assertEqualsFloat(rgb.r, crgb.r, TOLERANCE);
        assertEqualsFloat(rgb.g, crgb.g, TOLERANCE);
        assertEqualsFloat(rgb.b, crgb.b, TOLERANCE);
      }
      
      for(i = 0; i < ITERATIONS; i++)
      {
        hsl.h = changeScale(Math.random(), 0, 1, 0, 360);
        hsl.s = Math.random();
        hsl.l = Math.random();
        rgb = Hue.convertHSLToRGB(hsl);
        chsl = Hue.convertRGBToHSL(rgb);
        assertEqualsFloat(hsl.h, chsl.h, TOLERANCE);
        assertEqualsFloat(hsl.s, chsl.s, TOLERANCE);
        assertEqualsFloat(hsl.l, chsl.l, TOLERANCE);
      }
    }
    
    public static function changeScale(x:Number, a1:Number, b1:Number, a2:Number = 0, b2:Number = 1):Number
    {
      return (x * (a2 - b2) + a1 * b2 - a2 * b1) / (a1 - b1);
    }
  }
}

















