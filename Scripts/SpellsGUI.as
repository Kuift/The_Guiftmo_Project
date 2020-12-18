#include "Spell.as"
//thanks to epsilon for the starter code i started with.
class SpellsGUI
{
	private Spell@[] spells;
	private uint maxItems;
	private Spell@ selectedItem;
	private float displacementSpeed;
	private uint width;
	private uint height;
	private bool hasMoved;
	private Vec2f position;
	private Vec2f cellDim(40, 40);

	private string[] itemFilter;

	SpellsGUI(Vec2f position, array<string> filenames)
	{
		//this next line serve to change the width of the gui depending on the number of spell there is. by default it will be 5 spells per rows. 
		//if there are at least 15 spells in filenames, then the width will increase by 1. 
		int itemsPerRow = 5+int((filenames.size())/15);
		this.hasMoved = false;
		int nbOfItem = filenames.size();

		if(itemsPerRow == 0)
		{
			itemsPerRow = 1;
		}

		this.position = position;
		this.width = itemsPerRow;
		this.position = Vec2f(100,100);
		if(nbOfItem < itemsPerRow)
		{
			this.width = nbOfItem;
		}

		this.height = 1+(nbOfItem)/(itemsPerRow);
		this.maxItems = nbOfItem;
		this.displacementSpeed = 0.5f;

		for (uint i = 0; i < maxItems; i++)
		{
			spells.push_back(Spell("Bp" + i, filenames[i]));
		}
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

	void RemoveItem(Spell@ spell)
	{
		for (uint i = 0; i < spells.length; i++)
		{
			Spell@ item2 = spells[i];
			if (item2 is spell)
			{
				RemoveItem(i);
				return;
			}
		}
	}

	void RemoveItem(uint x, uint y)
	{
		uint index = getIndex(x, y);
		RemoveItem(index);
	}

	void RemoveItem(uint index)
	{
		if (hasItem(index))
		{
			spells.removeAt(index);
			print("Removed spell");
		}
	}

	Spell@ getItem(uint x, uint y)
	{
		uint index = getIndex(x, y);
		return getItem(index);
	}

	Spell@ getItem(uint index)
	{
		if (hasItem(index))
		{
			return spells[index];
		}
		return null;
	}

	int getItemIndex(Spell@ spell)
	{
		for (uint i = 0; i < spells.length; i++)
		{
			Spell@ item2 = spells[i];
			if (item2 is spell)
			{
				return i;
			}
		}
		return -1;
	}

	bool hasItem(Spell@ spell)
	{
		for (uint i = 0; i < spells.length; i++)
		{
			Spell@ item2 = spells[i];
			if (item2 is spell)
			{
				return true;
			}
		}
		return false;
	}

	bool hasItem(uint x, uint y)
	{
		uint index = getIndex(x, y);
		return hasItem(index);
	}

	bool hasItem(uint index)
	{
		if (index < spells.length)
		{
			return spells[index] !is null;
		}
		return false;
	}

	bool canAddItem(Spell@ spell)
	{
		return itemFilter.empty() || itemFilter.find(spell.name) > -1;
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

		if (hasSelectedItem())
		{
			Vec2f mousePos = controls.getMouseScreenPos();
			int oldIndex = getItemIndex(selectedItem);
			int index = getCellAtPoint(mousePos);
			if (oldIndex != index && index != -1)
			{
				Spell spell = selectedItem;
				RemoveItem(selectedItem);
				AddItem(spell, Maths::Min(index, spells.length));
				@selectedItem = spell;
				this.hasMoved = true;
			}

			if (!controls.isKeyPressed(KEY_LBUTTON))
			{
				print("Deselected " + selectedItem.name);
				string bpPath = selectedItem.path;
				@selectedItem = null;
				if(this.hasMoved == false)
				{
					return bpPath;
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
