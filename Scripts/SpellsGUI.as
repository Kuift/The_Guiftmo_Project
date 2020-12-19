#include "Spell.as"
#include "VertexAndIndexDataType.as"
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
	private VertexAndIndexDataType VIDT = VertexAndIndexDataType();
	SMesh@ GUIMesh = SMesh();
	SMaterial@ GUIMat = SMaterial();
	string SPELLSICONSPNG = "SPELLSICONS"; // CONST
	float guiRadius = 250; // CONST
	float guiOffsetX = 0; // CONST
	float guiOffsetY = 100; // CONST
	Driver@ driver;
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
		spells.push_back(Spell(VIDT,Icon(Vec2f(0.0f,0.0f), Vec2f(32.0f,32.0f))));
		float angleSeparation = 90/spells.size();
		@driver = getDriver();
		for (int i=0; i < spells.size() ; ++i)
		{
			spells[i].setRenderPosition(driver.getWorldPosFromScreenPos(Vec2f(getScreenWidth()/2 + Maths::Cos(45+angleSeparation*i)*guiRadius, getScreenHeight()/2 - Maths::Sin(45+angleSeparation*i)*guiRadius - guiOffsetY)));
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
		GUIMesh.SetVertex(VIDT.getVertexArray());
		GUIMesh.SetIndices(VIDT.getIndexArray()); 
		GUIMesh.BuildMesh();
		GUIMesh.SetDirty(SMesh::VERTEX_INDEX);
		GUIMesh.RenderMeshWithMaterial();
	}
}
