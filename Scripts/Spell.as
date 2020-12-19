#include "MeshGUIObject.as"
#include "Icon.as"
shared class Spell
{
	MeshGUIObject MGO;
	int charges;
	Spell(Vertex[] &vertexArray, u16[] &indexArray, Icon icon)
	{
		charges = 0;
		MGO = MeshGUIObject(Vertex[] &vertexArray, u16[] &indexArray, icon);
	}
	void setRenderPosition(position Vec2f)
	{
		MGO.setRenderPosition(position Vec2f);
	}
	void setRenderSize(Vec2f size)
	{
		MGO.setRenderSize(size);
	}
	int getNumberOfChargesLeft()
	{
		return charges;
	}
	int getSpellID()
	{
		return -1;
	}
	void setNewIcon(Icon newIcon)
	{
		MGO.setNewIcon(newIcon);
	}
	void addCharge(int numberOfCharges)
	{
		charges += numberOfCharges;
	}
	bool execute() // this is act as an abstract method, but angelscript don't allow those
	{
		return false;
	}
}
