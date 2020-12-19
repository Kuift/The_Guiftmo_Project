class Icon
{
    private Vec2f _textureCoordUpperLeft;
    private Vec2f _textureCoordBottomRight;
    private int TOTALTEXTUREWIDTH = 1024; //CONST
    private int TOTALTEXTUREHEIGHT = 1024; //CONST
	Icon(Vec2f textureCoordUpperLeft, Vec2f textureCoordBottomRight)
	{
        _textureCoordUpperLeft = textureCoordUpperLeft;
        _textureCoordBottomRight = textureCoordBottomRight;
	}

    float getUVX(int i)
    {
        if (i == 0 || i == 3)
        {
            return _textureCoordUpperLeft.x/TOTALTEXTUREWIDTH;
        }
        else
        {
            return _textureCoordBottomRight.x/TOTALTEXTUREWIDTH;
        }
    }
    float getUVY(int i)
    {
        if (i == 0 || i == 1)
        {
            return _textureCoordUpperLeft.y/TOTALTEXTUREHEIGHT;
        }
        else
        {
            return _textureCoordBottomRight.y/TOTALTEXTUREHEIGHT;
        }
    }
}
