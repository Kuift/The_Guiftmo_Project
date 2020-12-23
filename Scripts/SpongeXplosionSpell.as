class SpongeXplosionSpell: Spell
{
	SpongeXplosionSpell(VertexAndIndexDataType@ VIDT)
	{
        super(VIDT, Icon(Vec2f(31.0f,0.0f), Vec2f(104.0f,72.0f)));
	}
    int getSpellID() override
	{
		return 2;
	}
	bool execute() override
	{
		CBitStream params;
		CPlayer@ player = getLocalPlayer();
		uint16 id = player.getNetworkID();
		params.write_u16(id);
		getRules().SendCommand(getRules().getCommandID("spongeExplosion"), params);
		return true;
	}
}
