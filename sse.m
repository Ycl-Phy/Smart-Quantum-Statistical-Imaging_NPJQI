function res = sse(mat1,mat2)
    temp=(mat1-mat2).^2;
    res=sum(temp(:));