class FireballExplosionSpell: Spell
{
	FireballExplosionSpell(VertexAndIndexDataType@ VIDT)
	{
        super(VIDT, Icon(Vec2f(96.0f,0.0f), Vec2f(160.0f,64.0f)));
	}
    int getSpellID() override
	{
		return 3;
	}
	bool execute() override
	{
        print("fireball!");
		int nbOfSponges = 6;
		CBlob@ playerBlob = getLocalPlayerBlob();
		float strenght = 12.0f;
		Vec2f normalRightVector = Vec2f(16.0f, 0.0f);
		Vec2f rightVector = Vec2f(strenght,0.0f);
		if(playerBlob != null)
		{
			CBlob@ oldfireball;
			for(int i = 0; i < nbOfSponges; ++i)
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
					fireball.setPosition(playerBlob.getPosition() + normalRightVector.RotateBy(-160/nbOfSponges));
					fireball.setVelocity(rightVector.RotateBy(-160/nbOfSponges));
					fireball.SetLight(true);
					fireball.Tag("fire source");
					fireball.Untag("canbecontrolled");
				}
				@oldfireball = fireball;
			}
		}
		return true;
	}
}
