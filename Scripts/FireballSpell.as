class FireballSpell: Spell
{
	FireballSpell(VertexAndIndexDataType@ VIDT)
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
		int nbOfFireball = 3;
		CBlob@ playerBlob = getLocalPlayerBlob();
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
		return true;
	}
}
