#include "Icon.as"
#include "VertexAndIndexDataType.as"
class MeshGUIObject
{
    private Vec2f position;
    private int vertexArrayStartIndex;
    private int vertexArrayEndIndex;
    private int indexArrayStartIndex;
    private int indexArrayEndIndex;
    private VertexAndIndexDataType@ VIDT;
    private Icon _icon;
    private Vec2f size;
    
	MeshGUIObject(VertexAndIndexDataType@ newVIDT, Icon icon)
	{
        @VIDT = newVIDT;
        size = Vec2f(16.0f, 16.0f);
        _icon = icon;
        vertexArrayStartIndex = VIDT.getVertexArraySize();
        indexArrayStartIndex = VIDT.getIndexArraySize();
        VIDT.vraw_push_back(Vertex(0, 0, 1000, _icon.getUVX(0), _icon.getUVY(0),SColor(0xffffffff))); //upper left
		VIDT.vraw_push_back(Vertex(0, 0, 1000, _icon.getUVX(1), _icon.getUVY(1),SColor(0xffffffff))); //upper right
		VIDT.vraw_push_back(Vertex(0, 0, 1000, _icon.getUVX(2), _icon.getUVY(2),SColor(0xffffffff))); //bottom right
		VIDT.vraw_push_back(Vertex(0, 0, 1000, _icon.getUVX(3), _icon.getUVY(3),SColor(0xffffffff))); //bottom left
        
		VIDT.vi_push_back(vertexArrayStartIndex);
		VIDT.vi_push_back(vertexArrayStartIndex+1);
		VIDT.vi_push_back(vertexArrayStartIndex+2);
		VIDT.vi_push_back(vertexArrayStartIndex);
		VIDT.vi_push_back(vertexArrayStartIndex+2);
		VIDT.vi_push_back(vertexArrayStartIndex+3);
        print("PUSH HAPPENED");
        indexArrayStartIndex = VIDT.getVertexArraySize()-1;
        indexArrayEndIndex = VIDT.getIndexArraySize()-1;
        position = Vec2f(0.0f,0.0f);
	}

    void refresh()  
    {  
        VIDT.vraw_edit(vertexArrayStartIndex  , (Vertex(position.x - size.x, position.y - size.y, 1000, _icon.getUVX(0), _icon.getUVY(0),SColor(0xffffffff)))); //upper left
		VIDT.vraw_edit(vertexArrayStartIndex+1, (Vertex(position.x + size.x, position.y - size.y, 1000, _icon.getUVX(1), _icon.getUVY(1),SColor(0xffffffff)))); //upper right
		VIDT.vraw_edit(vertexArrayStartIndex+2, (Vertex(position.x + size.x, position.y + size.y, 1000, _icon.getUVX(2), _icon.getUVY(2),SColor(0xffffffff)))); //bottom right
		VIDT.vraw_edit(vertexArrayStartIndex+3, (Vertex(position.x - size.x, position.y + size.y, 1000, _icon.getUVX(3), _icon.getUVY(3),SColor(0xffffffff)))); //bottom left
    }

    void setRenderPosition(Vec2f newPosition)
    {
        position = newPosition;
        print("SET POSITION SET");
        VIDT.vraw_edit(vertexArrayStartIndex  ,(Vertex(position.x - size.x, position.y - size.y, 1000, _icon.getUVX(0), _icon.getUVY(0),SColor(0xffffffff)))); //upper left
		VIDT.vraw_edit(vertexArrayStartIndex+1,(Vertex(position.x + size.x, position.y - size.y, 1000, _icon.getUVX(1), _icon.getUVY(1),SColor(0xffffffff)))); //upper right
		VIDT.vraw_edit(vertexArrayStartIndex+2,(Vertex(position.x + size.x, position.y + size.y, 1000, _icon.getUVX(2), _icon.getUVY(2),SColor(0xffffffff)))); //bottom right
		VIDT.vraw_edit(vertexArrayStartIndex+3,(Vertex(position.x - size.x, position.y + size.y, 1000, _icon.getUVX(3), _icon.getUVY(3),SColor(0xffffffff)))); //bottom left
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
