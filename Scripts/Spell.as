#include "MeshGUIObject.as"
#include "Icon.as"
#include "VertexAndIndexDataType.as"
class Spell
{
	MeshGUIObject MGO;
	int charges;
	Spell(VertexAndIndexDataType@ VIDT, Icon icon)
	{
		charges = 0;
		MGO = MeshGUIObject(VIDT, icon);
	}
	void setRenderPosition(Vec2f position)
	{
		MGO.setRenderPosition(position);
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
	bool isMouseOver(Vec2f mousePos)
	{
		return MGO.isMouseOver(mousePos);
	}
	void setColor(SColor color)
	{
		MGO.setColor(color);
		MGO.refresh();
	}
	void setColorHovering()
	{
		this.setColor(SColor(0xff404040));
	}
	void setColorNormal()
	{
		this.setColor(SColor(0xffffffff));
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
