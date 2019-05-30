p1=x;
for i=1:size(resX,1)
    for j=1:size(resX,2)
        if resX(i,j)~=0
           p1(x==resX(i,j))=i-1;
        %x(find(x==resX(i,j)))=i-1;
        end
    end
end