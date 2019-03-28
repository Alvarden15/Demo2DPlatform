package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_9_9_RegionSceneSwitcher extends SceneScript
{
	public var _Region:Region;
	public var _Scene:Scene;
	public var _RegionSceneList:Array<Dynamic>;
	public var _Entry:Array<Dynamic>;
	public var _RegionID:Float;
	public var _SceneName:String;
	public var _XVar:Float;
	public var _YVar:Float;
	public var _ActorType:ActorType;
	public var _OnlySwitchOnKeyPress:Bool;
	public var _SwitchControl:String;
	public var _InRegion:Bool;
	public var _Done:Bool;
	public var _OutTime:Float;
	public var _InTime:Float;
	public var _TransitionStyle:String;
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_SwitchScene():Void
	{
		if(!(isTransitioning()))
		{
			if((_Entry.length >= 4))
			{
				_XVar = asNumber(_Entry[2]);
				_YVar = asNumber(_Entry[3]);
				createActorInNextScene(_ActorType, _XVar, _YVar, Script.FRONT);
			}
			if((_TransitionStyle == "Fade"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createFadeOut(_OutTime, Utils.getColorRGB(0,0,0)), createFadeIn(_InTime, Utils.getColorRGB(0,0,0)));
			}
			else if((_TransitionStyle == "Blinds"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createBlindsOut(_OutTime, Utils.getColorRGB(0,0,0)), createBlindsIn(_InTime, Utils.getColorRGB(0,0,0)));
			}
			else if((_TransitionStyle == "Bubbles"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createBubblesOut(_OutTime, Utils.getColorRGB(0,0,0)), createBubblesIn(_InTime, Utils.getColorRGB(0,0,0)));
			}
			else if((_TransitionStyle == "Spotlight"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createCircleOut(_OutTime, Utils.getColorRGB(0,0,0)), createCircleIn(_InTime, Utils.getColorRGB(0,0,0)));
			}
			else if((_TransitionStyle == "Blur"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createPixelizeOut(_OutTime, Utils.getColorRGB(0,0,0)), createPixelizeIn(_InTime, Utils.getColorRGB(0,0,0)));
			}
			else if((_TransitionStyle == "Box"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createRectangleOut(_OutTime, Utils.getColorRGB(0,0,0)), createRectangleIn(_InTime, Utils.getColorRGB(0,0,0)));
			}
			else if((_TransitionStyle == "Crossfade"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createCrossfadeTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Up"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createSlideUpTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Down"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createSlideDownTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Left"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createSlideLeftTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Right"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createSlideRightTransition(_OutTime));
			}
		}
	}
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Region", "_Region");
		nameMap.set("Scene", "_Scene");
		nameMap.set("Region Scene List", "_RegionSceneList");
		nameMap.set("Entry", "_Entry");
		nameMap.set("Region ID", "_RegionID");
		_RegionID = 0.0;
		nameMap.set("Scene Name", "_SceneName");
		_SceneName = "";
		nameMap.set("X", "_XVar");
		_XVar = 0.0;
		nameMap.set("Y", "_YVar");
		_YVar = 0.0;
		nameMap.set("Actor Type", "_ActorType");
		nameMap.set("Only Switch On Key Press", "_OnlySwitchOnKeyPress");
		_OnlySwitchOnKeyPress = false;
		nameMap.set("Switch Control", "_SwitchControl");
		nameMap.set("In Region", "_InRegion");
		_InRegion = false;
		nameMap.set("Done", "_Done");
		_Done = false;
		nameMap.set("Out Time", "_OutTime");
		_OutTime = 0.5;
		nameMap.set("In Time", "_InTime");
		_InTime = 0.5;
		nameMap.set("Transition Style", "_TransitionStyle");
		_TransitionStyle = "";
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_InRegion = false;
				if(((hasValue(_ActorType)) && !(isTransitioning())))
				{
					for(actorOfType in getActorsOfType(_ActorType))
					{
						if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
							for(item in cast(_RegionSceneList, Array<Dynamic>))
							{
								_Entry = ("" + item).split(",");
								if((_Entry.length >= 2))
								{
									_RegionID = asNumber(_Entry[0]);
									_SceneName = "" + _Entry[1];
									_Region = engine.getRegion(Std.int(_RegionID));
									if(isInRegion(actorOfType, _Region))
									{
										if(_OnlySwitchOnKeyPress)
										{
											_InRegion = true;
										}
										else
										{
											_customEvent_SwitchScene();
										}
										_Done = true;
										break;
									}
								}
							}
							if(_Done)
							{
								break;
							}
						}
					}
				}
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener(_SwitchControl, function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				if((_OnlySwitchOnKeyPress && _InRegion))
				{
					_customEvent_SwitchScene();
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}