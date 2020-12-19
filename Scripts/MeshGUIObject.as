#include "Icon.as"
class MeshGUIObject
{
    private Vec2f position;
    private int vertexArrayStartIndex;
    private int vertexArrayEndIndex;
    private int indexArrayStartIndex;
    private int indexArrayEndIndex;
    private Vertex[] v_raw;
    private u16[] v_i;
    private Icon _icon;
    private Vec2f size;
    
	MeshGUIObject(Vertex[] &vertexArray, u16[] &indexArray, Icon icon)
	{
        print("GOT HERE");
        size = Vec2f(16.0f, 16.0f);
        _icon = icon;
        vertexArrayStartIndex = vertexArray.size();
        indexArrayStartIndex = indexArray.size();
        v_raw = vertexArray;
        v_i = indexArray;
        v_raw.push_back(Vertex(0, 0, 1000, _icon.getUVX(0), _icon.getUVY(0),SColor(0x70aacdff))); //upper left
		v_raw.push_back(Vertex(0, 0, 1000, _icon.getUVX(1), _icon.getUVY(1),SColor(0x70aacdff))); //upper right
		v_raw.push_back(Vertex(0, 0, 1000, _icon.getUVX(2), _icon.getUVY(2),SColor(0x70aacdff))); //bottom right
		v_raw.push_back(Vertex(0, 0, 1000, _icon.getUVX(3), _icon.getUVY(3),SColor(0x70aacdff))); //bottom left
		v_i.push_back(vertexArrayStartIndex);
		v_i.push_back(vertexArrayStartIndex+1);
		v_i.push_back(vertexArrayStartIndex+2);
		v_i.push_back(vertexArrayStartIndex);
		v_i.push_back(vertexArrayStartIndex+2);
		v_i.push_back(vertexArrayStartIndex+3);
        print("PUSH HAPPENED");
        indexArrayStartIndex = v_raw.size()-1;
        indexArrayEndIndex = v_i.size()-1;
        position = Vec2f(0.0f,0.0f);
	}

    void refresh()
    {
        v_raw[vertexArrayStartIndex  ] = (Vertex(position.x - size.x, position.y - size.y, 1000, _icon.getUVX(0), _icon.getUVY(0),SColor(0x70aacdff))); //upper left
		v_raw[vertexArrayStartIndex+1] = (Vertex(position.x + size.x, position.y - size.y, 1000, _icon.getUVX(1), _icon.getUVY(1),SColor(0x70aacdff))); //upper right
		v_raw[vertexArrayStartIndex+2] = (Vertex(position.x + size.x, position.y + size.y, 1000, _icon.getUVX(2), _icon.getUVY(2),SColor(0x70aacdff))); //bottom right
		v_raw[vertexArrayStartIndex+3] = (Vertex(position.x - size.x, position.y + size.y, 1000, _icon.getUVX(3), _icon.getUVY(3),SColor(0x70aacdff))); //bottom left
    }

    void setRenderPosition(Vec2f newPosition)
    {
        position = newPosition;

        v_raw[vertexArrayStartIndex  ] = (Vertex(position.x - size.x, position.y - size.y, 1000, _icon.getUVX(0), _icon.getUVY(0),SColor(0x70aacdff))); //upper left
		v_raw[vertexArrayStartIndex+1] = (Vertex(position.x + size.x, position.y - size.y, 1000, _icon.getUVX(1), _icon.getUVY(1),SColor(0x70aacdff))); //upper right
		v_raw[vertexArrayStartIndex+2] = (Vertex(position.x + size.x, position.y + size.y, 1000, _icon.getUVX(2), _icon.getUVY(2),SColor(0x70aacdff))); //bottom right
		v_raw[vertexArrayStartIndex+3] = (Vertex(position.x - size.x, position.y + size.y, 1000, _icon.getUVX(3), _icon.getUVY(3),SColor(0x70aacdff))); //bottom left
    }  

    void setRenderSize(Vec2f newSize)
    {
        size = newSize;
    } 

    void setNewIcon(Icon icon)
    {
        _icon = icon;
    }

    Vec2f getPosition()
    {
        return position;
    }
}
