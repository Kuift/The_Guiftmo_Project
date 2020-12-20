class SpongeXplosionSpell: Spell
{
	SpongeXplosionSpell(VertexAndIndexDataType@ VIDT)
	{
        super(VIDT, Icon(Vec2f(32.0f,0.0f), Vec2f(96.0f,64.0f)));
	}
    int getSpellID() override
	{
		return 2;
	}
	bool execute() override
	{
        print("sponge explosion!");
		int nbOfSponges = 10;
		CBlob@ playerBlob = getLocalPlayerBlob();
		float strenght = 10.0f;
		Vec2f normalRightVector = Vec2f(1.0f, 0.0f);
		Vec2f rightVector = Vec2f(strenght,0.0f);
		if(playerBlob != null)
		{
			for(int i = 0; i < nbOfSponges; ++i)
			{
				CBlob@ sponge = server_CreateBlobNoInit("sponge");
				if (sponge != null)
				{
					sponge.Init();
					sponge.setPosition(playerBlob.getPosition() + normalRightVector.RotateBy(-169/nbOfSponges));
					sponge.setVelocity(rightVector.RotateBy(-169/nbOfSponges));
				}
			}
		}
		return true;
	}
}
