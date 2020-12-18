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
		spells.push_back(Spell(v_raw, v_i))
		float angleSeparation = 90/spells.size() 
		for (int i=0; i < spells.size() ; ++i)
		{
			spells[i].setRenderPosition(Vec2f(getScreenWidth()/2 + Maths::Cos(45+angleSeparation*i)*guiRadius, getScreenHeight()/2 - Maths::Sin(45+angleSeparation*i)*guiRadius - guiOffsetY));
		}
		/*GUIMesh.SetVertex(v_raw);
		GUIMesh.SetIndices(v_i); 
		GUIMesh.BuildMesh();
		GUIMesh.SetDirty(SMesh::VERTEX_INDEX);
		GUIMesh.RenderMeshWithMaterial();*/
	}
	void setPosition(Vec2f newpos)
	{
		position = newpos;
	}
	void SetItemFilter(string[] names)
	{
		itemFilter = names;
	}

	void resizeGUI(array<string> filenames) // called each time a new blueprint is created
	{
		int itemsPerRows = 5+int((filenames.size())/15);
		this.hasMoved = false;
		int nbOfItem = filenames.size();

		if(nbOfItem < itemsPerRows)
		{
			this.width = nbOfItem;
		}

		this.height = 1+(nbOfItem)/itemsPerRows;
		this.maxItems = nbOfItem;

		spells.push_back(Spell("Bp" + (filenames.size()-1), filenames[filenames.size()-1]));
	}

	bool AddItem(Spell@ spell)
	{
		if (spells.length < maxItems && canAddItem(spell))
		{
			spells.push_back(spell);
			print("Added spell: " + spell.name);
			return true;
		}
		return false;
	}

	bool AddItem(Spell@ spell, uint index)
	{
		if (spells.length < maxItems && canAddItem(spell) && index <= spells.length)
		{
			spells.insertAt(index, spell);
			print("Added spell at index: " + spell.name);
			return true;
		}
		return false;
	}

	bool canAddItem(Spell@ spell)
	{
		return f.empty() || itemFilter.find(spell.name) > -1;
	}

	string Update()
	{
		CControls@ controls = getControls();

		if (controls.isKeyJustPressed(KEY_LBUTTON) && !hasSelectedItem())
		{
			Vec2f mousePos = controls.getMouseScreenPos();
			int index = getCellAtPoint(mousePos);
			if (index > -1)
			{
				Spell@ spell = getItem(index);
				if (spell !is null)
				{
					@selectedItem = spell;
					print("Selected " + spell.name);
					this.hasMoved = false;
				}
			}
		}

		return "";
	}

	void Render()
	{
		
		Vec2f tl = position;
		Vec2f br = tl + Vec2f(cellDim.x * width, cellDim.y * height);
		GUI::DrawRectangle(tl - Vec2f(1, 1), br + Vec2f(1, 1), SColor(0x40E6A800));

		for (uint i = 0; i < spells.length; i++)
		{
			Spell@ spell = spells[i];
			uint x = i % width;
			uint y = i / width;

			Vec2f goalPos = position + Vec2f(x * cellDim.x, y * cellDim.y);
			spell.position += (goalPos - spell.position) * this.displacementSpeed;
			Vec2f pos(Maths::Round(spell.position.x), Maths::Round(spell.position.y));

			SColor color = selectedItem is spell ? SColor(255, 150, 150, 150) : color_white;
			GUI::DrawRectangle(pos + Vec2f(1, 1), pos + cellDim - Vec2f(1, 1), color);
			GUI::DrawTextCentered(spell.name, pos + cellDim / 2.0f, color_black);
		}

		Vec2f mousePos = getControls().getInterpMouseScreenPos();
		int index = getCellAtPoint(mousePos);
		if (index > -1)
		{
			GUI::DrawTextCentered(""+index, mousePos - Vec2f(0, 10), SColor(255, 255, 0, 0));
		}
		
	}

	bool hasSelectedItem()
	{
		return selectedItem !is null;
	}

	int getCellAtPoint(Vec2f point)
	{
		Vec2f pos = point - position;
		int x = Maths::Floor(pos.x / cellDim.x);
		int y = Maths::Floor(pos.y / cellDim.y);
		if (x >= 0 && x < width && y >= 0 && y < height)
		{
			uint index = x + y * width;
			return index;
		}
		return -1;
	}

	private uint getIndex(uint x, uint y)
	{
		return x + y * width;
	}
}
