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



class Design_18_18_FlickerOnCollision extends ActorScript
{
	public var _FlickerTime:Float;
	public var _NumberofFlickers:Float;
	public var _Flickering:Bool;
	public var _FlickerOpacity:Float;
	public var _Fade:Bool;
	public var _FlickerLength:Float;
	public var _Stop:Bool;
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_Flicker():Void
	{
		if(!(_Flickering))
		{
			_Flickering = true;
			runLater(1000 * _FlickerTime, function(timeTask:TimedTask):Void
			{
				_Stop = true;
			}, actor);
			runPeriodically(1000 * _FlickerLength, function(timeTask:TimedTask):Void
			{
				if(_Stop)
				{
					_Stop = false;
					_Flickering = false;
					timeTask.repeats = false;
					return;
				}
				if(_Fade)
				{
					actor.fadeTo(_FlickerOpacity / 100, (_FlickerLength / 2), Easing.linear);
				}
				else
				{
					actor.fadeTo(_FlickerOpacity / 100, 0, Easing.linear);
				}
				runLater(1000 * (_FlickerLength / 2), function(timeTask:TimedTask):Void
				{
					if(_Fade)
					{
						actor.fadeTo(100 / 100, (_FlickerLength / 2), Easing.linear);
					}
					else
					{
						actor.fadeTo(100 / 100, 0, Easing.linear);
					}
				}, actor);
			}, actor);
		}
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Flicker Time", "_FlickerTime");
		_FlickerTime = 1.0;
		nameMap.set("Number of Flickers", "_NumberofFlickers");
		_NumberofFlickers = 3.0;
		nameMap.set("Flickering", "_Flickering");
		_Flickering = false;
		nameMap.set("Flicker Opacity", "_FlickerOpacity");
		_FlickerOpacity = 0.0;
		nameMap.set("Fade", "_Fade");
		_Fade = true;
		nameMap.set("Flicker Length", "_FlickerLength");
		_FlickerLength = 0.0;
		nameMap.set("Stop", "_Stop");
		_Stop = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_FlickerLength = (_FlickerTime / (_NumberofFlickers + 1));
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(4),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if(!(event.thisFromBottom))
				{
					_customEvent_Flicker();
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}