function [ imageName ] = getImageName( i )
if(i<10)
formatSpec = 'sequence/2043_000%d.jpeg';
else
 formatSpec = 'sequence/2043_000%d.jpeg';
    
end

imageName =  sprintf(formatSpec,i);
end