class VertexAndIndexDataType
{
	private u16[] v_i;
	private Vertex[] v_raw;
	VertexAndIndexDataType()
	{
	}

    Vertex[] getVertexArray()
    {
        return v_raw;
    }
    u16[] getIndexArray()
    {
        return v_i;
    }
    int getVertexArraySize()
    {
        return v_raw.size();
    }
    int getIndexArraySize()
    {
        return v_i.size();
    }
    void vi_push_back(int i)
    {
        v_i.push_back(i);
    }
    void vraw_push_back(Vertex i)
    {
        v_raw.push_back(i);
    }
    void vraw_edit(int index, Vertex i)
    {
        v_raw[index] = i;
    }
}