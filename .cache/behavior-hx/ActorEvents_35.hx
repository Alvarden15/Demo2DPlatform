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



class ActorEvents_35 extends ActorScript
{
	public var _CurrentHealth:Float;
	public var _StartingHealth:Float;
	public var _HealthIdentifier:String;
	public var _PersistentHealth:Bool;
	public var _ZeroHealthAction:String;
	public var _PercentLeft:Float;
	public var _MaximumHealth:Float;
	public var _Health:Float;
	public var _DrawingLocation:String;
	public var _HealthBarXOffset:Float;
	public var _HealthBarOutlineSize:Float;
	public var _HealthBarYOffset:Float;
	public var _HealthBarWidth:Float;
	public var _HealthBarHeight:Float;
	public var _HealthBarOrientation:String;
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_Hit():Void
	{
		_Health -= 1;
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Current Health", "_CurrentHealth");
		_CurrentHealth = 3.0;
		nameMap.set("Starting Health", "_StartingHealth");
		_StartingHealth = 3.0;
		nameMap.set("Health Identifier", "_HealthIdentifier");
		_HealthIdentifier = "";
		nameMap.set("Persistent Health?", "_PersistentHealth");
		_PersistentHealth = false;
		nameMap.set("Zero Health Action", "_ZeroHealthAction");
		_ZeroHealthAction = "";
		nameMap.set("Percent Left", "_PercentLeft");
		_PercentLeft = 0.0;
		nameMap.set("Maximum Health", "_MaximumHealth");
		_MaximumHealth = 3.0;
		nameMap.set("Health", "_Health");
		_Health = 0.0;
		nameMap.set("Drawing Location", "_DrawingLocation");
		_DrawingLocation = "";
		nameMap.set("Health Bar X Offset", "_HealthBarXOffset");
		_HealthBarXOffset = 0.0;
		nameMap.set("Health Bar Outline Size", "_HealthBarOutlineSize");
		_HealthBarOutlineSize = 1.0;
		nameMap.set("Health Bar Y Offset", "_HealthBarYOffset");
		_HealthBarYOffset = 0.0;
		nameMap.set("Health Bar Width", "_HealthBarWidth");
		_HealthBarWidth = 100.0;
		nameMap.set("Health Bar Height", "_HealthBarHeight");
		_HealthBarHeight = 5.0;
		nameMap.set("Health Bar Orientation", "_HealthBarOrientation");
		_HealthBarOrientation = "";
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_Health = 3;
		_MaximumHealth = 3;
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_PercentLeft = (_Health / _MaximumHealth);
				if((_Health <= 0))
				{
					setVolumeForAllSounds(70/100);
					actor.setXVelocity(0);
					actor.setYVelocity(0);
					actor.setAnimation("Blow");
					runLater(1000 * 0.2, function(timeTask:TimedTask):Void
					{
						recycleActor(actor);
					}, actor);
				}
			}
		});
		
		/* ======================== Specific Actor ======================== */
		addWhenKilledListener(actor, function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				sayToScene("Score Manager", "_customBlock_IncrementScore", [250]);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}