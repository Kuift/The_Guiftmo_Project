#include "SpellsGUI.as"
#include "Spell.as"

bool showGUI = false;
SpellsGUI@ spellgui; 

void onInit(CRules@ this)
{
		this.addCommandID("fireExplosion");
		this.addCommandID("spongeExplosion");
		this.addCommandID("controllableFireball");
    	if(isClient())
	    {
            @spellgui = SpellsGUI(); // constructor : SpellsGUI(Vec2f position, int numberOfBlueprint, int number of item per rows)
		    int cb_id = Render::addScript(Render::layer_posthud, "GUIrenderer.as", "RenderAdvancedGui", 0.0f);
        }
}

void RenderAdvancedGui(int id)
{
	if(showGUI)
	{
		spellgui.Render();
	}
}

void KeyDetector()
{
    CControls@ c = getControls();
	if (c is null) return;
    if(c.isKeyJustPressed(KEY_KEY_R))
	{
		showGUI = !showGUI;
		if(showGUI)
		{
			spellgui.setGUIOrigin(c.getMouseScreenPos());
		}
		print("show gui : " + showGUI);
	}
}

void onTick(CRules@ this)
{
    if(isClient())
    {
        KeyDetector();
		if(showGUI)
		{
			showGUI = spellgui.Update();
		}
    }
}

void addCharge(int spellID)
{
	
}


bool isDebugMode = true; // this is necessary because client/server interaction stuff doesn't work well when ran locally


//implementation of spells are forced here due to how kag engine work
void onCommand(CRules@ this, u8 cmd, CBitStream @params)
{
	if(!isClient() || isDebugMode)
	{
		if (cmd == this.getCommandID("fireExplosion"))
		{
			uint16 netID = params.read_u16();
			CBlob@ playerBlob = getPlayerByNetworkId(netID).getBlob();
			int nbOfFireballs = 6;
			float strenght = 12.0f;
			Vec2f normalRightVector = Vec2f(16.0f, 0.0f);
			Vec2f rightVector = Vec2f(strenght,0.0f);
			if(playerBlob != null)
			{
				CBlob@ oldfireball;
				for(int i = 0; i < nbOfFireballs; ++i)
				{
					CBlob@ fireball = server_CreateBlobNoInit("fireball");
					if (fireball != null)
					{		
						fireball.SetDamageOwnerPlayer(playerBlob.getPlayer());

						fireball.Init();
						fireball.IgnoreCollisionWhileOverlapped(playerBlob);
						if (oldfireball != null)
						{
							fireball.IgnoreCollisionWhileOverlapped(oldfireball);
						}
						fireball.server_setTeamNum(playerBlob.getTeamNum());
						fireball.setPosition(playerBlob.getPosition() + normalRightVector.RotateBy(-160/nbOfFireballs));
						fireball.setVelocity(rightVector.RotateBy(-160/nbOfFireballs));
						fireball.SetLight(true);
						fireball.Tag("fire source");
						fireball.Untag("canbecontrolled");
					}
					@oldfireball = fireball;
				}
			}
			else{
				print("ERROR : fire explosion player blob was null");
			}
		}
		else if (cmd == this.getCommandID("spongeExplosion"))
		{
			uint16 netID = params.read_u16();
			CBlob@ playerBlob = getPlayerByNetworkId(netID).getBlob();
			int nbOfSponges = 10;
			float strenght = 10.0f;
			Vec2f normalRightVector = Vec2f(1.0f, 0.0f);
			Vec2f rightVector = Vec2f(strenght,0.0f);
			if(playerBlob != null)
			{
				Vec2f currentPos = playerBlob.getPosition();
				for(int i = 0; i < nbOfSponges; ++i)
				{
					CBlob@ sponge = server_CreateBlobNoInit("sponge");
					if (sponge != null)
					{
						sponge.Init();
						sponge.setPosition(currentPos + normalRightVector.RotateBy(-169/nbOfSponges));
						sponge.setVelocity(rightVector.RotateBy(-169/nbOfSponges));
					}
				}
				Sound::Play("/Sounds/sponge1.ogg", currentPos, 100.0f);
			}
			else{
				print("ERROR : sponge explosion player blob was null");
			}
		}
		else if(cmd == this.getCommandID("controllableFireball"))
		{
			uint16 netID = params.read_u16();
			CBlob@ playerBlob = getPlayerByNetworkId(netID).getBlob();
			int nbOfFireball = 3;
			float strenght = 9.0f;
			Vec2f normalRightVector = Vec2f(32.0f, 0.0f);
			Vec2f rightVector = Vec2f(strenght,0.0f).RotateBy(-90);
			if(playerBlob != null)
			{
				Vec2f playerpos = playerBlob.getPosition();
				CBlob@ oldfireball;
				for(int i = 0; i < nbOfFireball; ++i)
				{
					CBlob@ fireball = server_CreateBlobNoInit("fireball");
					if (fireball != null)
					{		
						fireball.SetDamageOwnerPlayer(playerBlob.getPlayer());

						fireball.Init();
						fireball.IgnoreCollisionWhileOverlapped(playerBlob);
						if (oldfireball != null)
						{
							fireball.IgnoreCollisionWhileOverlapped(oldfireball);
						}
						fireball.server_setTeamNum(playerBlob.getTeamNum());
						fireball.setPosition(playerpos + Vec2f(i*8.0f*Maths::Pow(-1.0f,i), -8.0f));
						fireball.setVelocity(rightVector + Vec2f(i*.5f*Maths::Pow(-1.0f,i), 0.0f-0.6f*Maths::Pow(-1.0f,i)));
						fireball.SetLight(true);
						fireball.Tag("fire source");
						fireball.Tag("canbecontrolled");
					}
					@oldfireball = fireball;
				}
			}
		}
	}
}