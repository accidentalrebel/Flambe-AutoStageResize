package game;
import flambe.display.Sprite;
import flambe.System;

class MainStage
{	
	static public var computedStageScale(get, null) : Float;	
	static public var width(get, null) : Float;
	static public var height(get, null) : Float;
	
	static private var _mainStageSprite:Sprite;
	static private var _designSizeWidth:Float;
	static private var _designSizeHeight:Float;
	static private var _computedStageScale:Float;
	
	static public function init(designSizeWidth : Float, designSizeHeight : Float) 
	{
		_designSizeWidth = designSizeWidth;
		_designSizeHeight = designSizeHeight;
		
		_mainStageSprite = new Sprite();
		System.root.add(_mainStageSprite);
		
		setupStageResizeListener();
		
		resizeStage();
	}
	
	// ============================================= SETUP ============================================= //
	static function setupStageResizeListener() 
	{
		System.stage.resize.connect(onStageResize);
	}
	
	// ============================================= EVENTS ============================================= //
	static function onStageResize()
	{
		resizeStage();
	}
	
	// ============================================= HELPERS ============================================= //
	static function resizeStage() 
	{		
		_computedStageScale = computeScaleAccordingToNewStageDimensions();     	
		_mainStageSprite.setScale(_computedStageScale);
		
		centerStage();
	}
	
	static function computeScaleAccordingToNewStageDimensions() : Float
	{
		var currentStageWidth : Float = System.stage.width;
		var currentStageHeight : Float = System.stage.height;
		
		var idealWidth  : Float = _designSizeWidth;
		var idealHeight : Float = _designSizeHeight;
		
		var computedScale : Float = 1;
		if ( currentStageWidth / idealWidth < currentStageHeight / idealHeight ) 
			computedScale = currentStageWidth/idealWidth;
		else 
			computedScale = currentStageHeight / idealHeight;    
			
		return computedScale;
	}
	
	static function centerStage() 
	{
		var xDiff:Float = System.stage.width - (_designSizeWidth * _computedStageScale);
		var yDiff:Float = System.stage.height - (_designSizeHeight * _computedStageScale);
		
		_mainStageSprite.x._ = xDiff / 2;
		_mainStageSprite.y._ = yDiff / 2;
	}
	
	// ============================================= GETTERS AND SETTERS ============================================= //
	static function get_computedStageScale():Float { return _computedStageScale; }
	static function get_width():Float { return _designSizeWidth; }
	static function get_height():Float { return _designSizeHeight; }
}