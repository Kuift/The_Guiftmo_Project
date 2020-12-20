#include "SpellsGUI.as"
#include "Spell.as"

bool showGUI = false;
SpellsGUI@ spellgui; 

void onInit(CRules@ this)
{
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