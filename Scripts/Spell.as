shared class Spell
{
	string name;
	Vec2f position;
	string path;
	Spell(string name, string newPath)
	{
		this.name = name;
		this.path = newPath;
	}
}
