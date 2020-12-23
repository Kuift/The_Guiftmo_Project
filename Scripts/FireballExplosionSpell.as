#include "GUIRenderer.as"
class FireballExplosionSpell: Spell
{
	FireballExplosionSpell(VertexAndIndexDataType@ VIDT)
	{
        super(VIDT, Icon(Vec2f(176.0f,1.0f), Vec2f(248.0f,72.0f)));
	}
    int getSpellID() override
	{
		return 3;
	}
	bool execute() override
	{
		CBitStream params;
		CPlayer@ player = getLocalPlayer();
		uint16 id = player.getNetworkID();
		params.write_u16(id);
		getRules().SendCommand(getRules().getCommandID("fireExplosion"), params);
		return true;
	}
}
