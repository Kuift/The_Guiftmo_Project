class SpongeXplosionSpell: Spell
{
	SpongeXplosionSpell(VertexAndIndexDataType@ VIDT)
	{
        super(VIDT, Icon(Vec2f(33.0f,0.0f), Vec2f(96.0f,64.0f)))
	}
    int getSpellID() override
	{
		return 2;
	}
	bool execute() override
	{
        print("sponge explosion!");
		return true;
	}
}
