class MeshGUIObject
{
    private Vec2f position;
    private int vertexArrayStartIndex;
    private int vertexArrayEndIndex;
    private int indexArrayStartIndex;
    private int indexArrayEndIndex;
    private Vertex[]@ v_raw;
    private u16[]@ v_i;
	MeshGUIObject(Vertex[] &vertexArray, u16[] &indexArray)
	{
        vertexArrayStartIndex = vertexArray.size();
        indexArrayStartIndex = indexArray.size();
        v_raw = vertexArray;
        v_i = indexArray;
        position = Vec2f(0.0f,0.0f);
	}
    setRenderPosition(Vec2f newPosition)
    {
        position = newPosition;
    }
    getPosition()
    {
        return position;
    }
}
