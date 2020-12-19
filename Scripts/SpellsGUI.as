#include "Spell.as"

//thanks to epsilon for the starter code.
class SpellsGUI
{
	private Spell@[] spells;
	private Spell@ selectedItem;
	private float displacementSpeed;
	private Vec2f position;
	private Vec2f cellDim(40, 40);
	private string[] itemFilter;
	private string GUITexture;
	private u16[] v_i;
	private Vertex[] v_raw;
	SMesh@ GUIMesh = SMesh();
	SMaterial@ GUIMat = SMaterial();
	const string SPELLSICONSPNG = "SPELLSICONS";
	const float guiRadius = 250;
	const float guiOffsetX = 0;
	const float guiOffsetY = 100; 
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
		spells.push_back(Spell(v_raw, v_i,Icon(Vec2f(0.0f,0.0f), Vec2f(32.0f,32.0f))));
		float angleSeparation = 90/spells.size();
		for (int i=0; i < spells.size() ; ++i)
		{
			spells[i].setRenderPosition(Vec2f(getScreenWidth()/2 + Maths::Cos(45+angleSeparation*i)*guiRadius, getScreenHeight()/2 - Maths::Sin(45+angleSeparation*i)*guiRadius - guiOffsetY));
		}

	}

	string Update()
	{
		CControls@ controls = getControls();

		if (controls.isKeyJustPressed(KEY_LBUTTON))
		{
			Vec2f mousePos = controls.getMouseScreenPos();
			print("mouse pos : " + mousePos);
		}

		return "";
	}

	void Render()
	{
		GUIMesh.SetVertex(v_raw);
		GUIMesh.SetIndices(v_i); 
		GUIMesh.BuildMesh();
		GUIMesh.SetDirty(SMesh::VERTEX_INDEX);
		GUIMesh.RenderMeshWithMaterial();
	}
}
