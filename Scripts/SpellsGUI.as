#include "Spell.as"
#include "VertexAndIndexDataType.as"
#include "SpongeXplosionSpell.as"
#include "FireballSpell.as"
#include "FireballExplosionSpell.as"
//thanks to epsilon for the starter code.
class SpellsGUI
{
	private Spell@[] spells;

	private VertexAndIndexDataType VIDT = VertexAndIndexDataType();
	
	SMesh@ GUIMesh = SMesh();
	SMaterial@ GUIMat = SMaterial();
	string SPELLSICONSPNG = "SPELLSICONS"; // CONST

	float guiRadius = 100; // CONST
	float guiOffsetX = 0; // CONST
	float guiOffsetY = 0; // CONST

	Driver@ driver;
	Vec2f origin = Vec2f(0.0f,0.0f);

	SpellsGUI()
	{
		if(!Texture::exists(SPELLSICONSPNG))
		{
			print("creating texture...");
			Texture::createFromFile(SPELLSICONSPNG,"/GUI/spellsIcons.png");
			GUIMat.AddTexture(SPELLSICONSPNG, 0);
			GUIMat.DisableAllFlags();
			GUIMat.SetFlag(SMaterial::COLOR_MASK, true);
			GUIMat.SetFlag(SMaterial::ZBUFFER, true);
			GUIMat.SetFlag(SMaterial::ZWRITE_ENABLE, true);
			GUIMat.SetMaterialType(SMaterial::TRANSPARENT_VERTEX_ALPHA);
			
			GUIMesh.SetMaterial(GUIMat);
			GUIMesh.SetHardwareMapping(SMesh::STATIC);
		}
		//spells.push_back(Spell(VIDT,Icon(Vec2f(1.0f,1.0f), Vec2f(32.0f,32.0f))));
		spells.push_back(SpongeXplosionSpell(VIDT));
		spells.push_back(FireballSpell(VIDT));
		spells.push_back(FireballExplosionSpell(VIDT));
	}

	bool Update()
	{
		CControls@ controls = getControls();
		if (controls != null)
		{
			Spell@ tempspell = null;
			for (int i=0; i < spells.size() ; ++i)
			{
				// following could be optimised if i know in advance where all the spell position are at
				// this could be done using the math equation to place them in the first place
				if(spells[i].isMouseOver(controls.getMouseScreenPos()))
				{
					@tempspell = spells[i];
					spells[i].setColorHovering();
				}
				else{
					spells[i].setColorNormal();
				}
			}
			if (controls.isKeyJustPressed(KEY_LBUTTON))
			{
				Vec2f mousePos = controls.getMouseScreenPos();
				if(tempspell != null)
				{
					tempspell.execute();
				}
				return false;
			}
		}

		return true;
	}
	void setGUIOrigin(Vec2f newOrigin)
	{
		origin = newOrigin;
	}
	void Render()
	{
		float angleSeparation = 90/spells.size();
		for (int i=0; i < spells.size() ; ++i)
		{
			spells[i].setRenderPosition(Vec2f(origin.x + Maths::Cos(45+angleSeparation*i)*guiRadius,  origin.y - Maths::Sin(45+angleSeparation*i)*guiRadius - guiOffsetY));
		}
		Render::SetTransformScreenspace();
		GUIMesh.SetVertex(VIDT.getVertexArray());
		GUIMesh.SetIndices(VIDT.getIndexArray()); 
		GUIMesh.BuildMesh();
		GUIMesh.SetDirty(SMesh::VERTEX_INDEX);
		GUIMesh.RenderMeshWithMaterial();
	}
}
