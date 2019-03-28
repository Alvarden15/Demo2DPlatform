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



class Design_36_36_Wander extends ActorScript
{
	public var _MinimumMovingTime:Float;
	public var _MaximumMovingTime:Float;
	public var _MinimumWaitingTime:Float;
	public var _MaximumWaitingTime:Float;
	public var _StartwithWaiting:Bool;
	public var _MaximumSpeed:Float;
	public var _Wait:Bool;
	public var _Move:Bool;
	public var _MinimumSpeed:Float;
	public var _ChangeDirectionwhenColliding:Bool;
	public var _SpeedX:Float;
	public var _SpeedY:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Minimum Moving Time", "_MinimumMovingTime");
		_MinimumMovingTime = 1.0;
		nameMap.set("Maximum Moving Time", "_MaximumMovingTime");
		_MaximumMovingTime = 2.0;
		nameMap.set("Minimum Waiting Time", "_MinimumWaitingTime");
		_MinimumWaitingTime = 1.0;
		nameMap.set("Maximum Waiting Time", "_MaximumWaitingTime");
		_MaximumWaitingTime = 2.0;
		nameMap.set("Start with Waiting", "_StartwithWaiting");
		_StartwithWaiting = true;
		nameMap.set("Maximum Speed", "_MaximumSpeed");
		_MaximumSpeed = 10.0;
		nameMap.set("Wait", "_Wait");
		_Wait = false;
		nameMap.set("Move", "_Move");
		_Move = false;
		nameMap.set("Minimum Speed", "_MinimumSpeed");
		_MinimumSpeed = 5.0;
		nameMap.set("Change Direction when Colliding", "_ChangeDirectionwhenColliding");
		_ChangeDirectionwhenColliding = true;
		nameMap.set("Speed X", "_SpeedX");
		_SpeedX = 0.0;
		nameMap.set("Speed Y", "_SpeedY");
		_SpeedY = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_Wait = _StartwithWaiting;
		_Move = !(_StartwithWaiting);
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_Wait)
				{
					_Wait = false;
					runLater(1000 * (_MinimumWaitingTime + (randomFloat() * (_MaximumWaitingTime - _MinimumWaitingTime))), function(timeTask:TimedTask):Void
					{
						_Move = true;
					}, actor);
					actor.setVelocity(0, 0);
					_SpeedX = 0;
					_SpeedY = 0;
				}
				if(_Move)
				{
					_Move = false;
					runLater(1000 * (_MinimumMovingTime + (randomFloat() * (_MaximumMovingTime - _MinimumMovingTime))), function(timeTask:TimedTask):Void
					{
						_Wait = true;
					}, actor);
					actor.setVelocity(randomInt(-180, 180), randomInt(Std.int(_MinimumSpeed), Std.int(_MaximumSpeed)));
					_SpeedX = actor.getXVelocity();
					_SpeedY = actor.getYVelocity();
				}
			}
		});
		
		/* ======================== Something Else ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_ChangeDirectionwhenColliding)
				{
					if((event.thisFromLeft || event.thisFromRight))
					{
						actor.setXVelocity(-(_SpeedX));
					}
					if((event.thisFromTop || event.thisFromBottom))
					{
						actor.setYVelocity(-(_SpeedY));
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}