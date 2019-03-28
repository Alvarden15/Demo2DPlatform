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



class ActorEvents_54 extends ActorScript
{
	public var _Bullet:Actor;
	public var _Health:Float;
	public var _StompedAnimation:String;
	public var _SpeedX:Float;
	public var _SpeedY:Float;
	public var _XVar:Float;
	public var _YVar:Float;
	public var _MoveRight:Bool;
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_Hit():Void
	{
		_Health -= 1;
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Bullet", "_Bullet");
		nameMap.set("Health", "_Health");
		_Health = 0.0;
		nameMap.set("Stomped Animation", "_StompedAnimation");
		nameMap.set("Speed X", "_SpeedX");
		_SpeedX = 0.0;
		nameMap.set("Speed Y", "_SpeedY");
		_SpeedY = 0.0;
		nameMap.set("X", "_XVar");
		_XVar = 0.0;
		nameMap.set("Y", "_YVar");
		_YVar = 0.0;
		nameMap.set("MoveRight", "_MoveRight");
		_MoveRight = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_Health = 1;
		_SpeedX = 5;
		_MoveRight = true;
		
		/* ======================== Specific Actor ======================== */
		addWhenKilledListener(actor, function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				sayToScene("Score Manager", "_customBlock_IncrementScore", [100]);
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				actor.setXVelocity(_SpeedX);
				if((_Health <= 0))
				{
					actor.setXVelocity(0);
					actor.setYVelocity(0);
					actor.setIgnoreGravity(!false);
					actor.enableRotation();
					actor.setAnimation("Stomped");
					runLater(1000 * 0.2, function(timeTask:TimedTask):Void
					{
						recycleActor(actor);
					}, actor);
				}
			}
		});
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(1),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if((_MoveRight == true))
				{
					_XVar = getTilePosition(0, (actor.getXCenter() + (0.4 * (actor.getWidth()))));
				}
				else
				{
					_XVar = getTilePosition(0, (actor.getXCenter() - (0.4 * (actor.getWidth()))));
				}
				_YVar = getTilePosition(1, (actor.getY() + (actor.getHeight())));
				if(!(tileCollisionAt(Std.int(_YVar), Std.int(_XVar), engine.getLayerById(0))))
				{
					if((_MoveRight == false))
					{
						_MoveRight = true;
						_SpeedX = 5;
					}
					else
					{
						_MoveRight = false;
						_SpeedX = -5;
					}
				}
				if((event.thisFromLeft || event.thisFromRight))
				{
					if((_MoveRight == false))
					{
						_MoveRight = true;
						_SpeedX = 5;
					}
					else
					{
						_MoveRight = false;
						_SpeedX = -5;
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}