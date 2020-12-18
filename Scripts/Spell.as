shared class Spell
{
	MeshGUIObject MGO;
	Spell()
	{
		MGO = MeshGUIObject(Vertex[] &vertexArray, u16[] &indexArray);
	}
	void setRenderPosition(position Vec2f)
	{
		MGO.setRenderPosition(position Vec2f);
	}
	int getSpellID()
	{
		return -1;
	}
}
