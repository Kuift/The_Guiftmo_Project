#include "SpellsGUI.as"
#include "Spell.as"

bool showGUI = false;
Inventory@ inv; 

void onInit(CRules@ this)
{
    	if(isClient())
	    {
            @inv = Inventory(Vec2f(100,100), filenames); // constructor : Inventory(Vec2f position, int numberOfBlueprint, int number of item per rows)
		    int cb_id = Render::addScript(Render::layer_prehud, "GUIrenderer.as", "RenderAdvancedGui", 0.0f);
        }
}

void RenderAdvancedGui(int id)
{
	if(showGUI)
	{
		inv.Render();
	}
}

void KeyDetector()
{
    CControls@ c = getControls();
	if (c is null) return;
    if(c.isKeyJustPressed(KEY_KEY_T))
	{
        inv.Update();
		print("Trigger GUI Event");
	}
}

void onTick(CRules@ this)
{
    if(isClient())
    {
        KeyDetector();
    }
}